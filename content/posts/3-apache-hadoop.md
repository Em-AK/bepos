---
title: "Apache Hadoop"
created_at: 2013-09-20 23:00:00 +0000
kind: article
---

**From Wikipedia, the free encyclopedia**

Apache Hadoop is an open-source software framework that supports data-intensive distributed applications, licensed under the **Apache** v2 license. It supports the running of applications on large clusters of commodity hardware. Hadoop was derived from Google's MapReduce and Google File System (GFS) papers.

The Hadoop framework transparently provides both reliability and data motion to applications. Hadoop implements a computational paradigm named MapReduce,[2] where the application is divided into many small fragments of work, each of which may be executed or re-executed on any node in the cluster. In addition, it provides a distributed file system that stores data on the compute nodes, providing very high aggregate bandwidth across the cluster. Both map/reduce and the distributed file system are designed so that node failures are automatically handled by the framework.[3] It enables applications to work with thousands of computation-independent computers and petabytes of data. The entire Apache Hadoop “platform” is now commonly considered to consist of the Hadoop kernel, MapReduce and Hadoop Distributed File System (HDFS), as well as a number of related projects – including Apache Hive, Apache HBase, and others.[4]

Hadoop is written in the Java programming language and is an Apache top-level project being built and used by a global community of contributors.[5] Hadoop and its related projects (Hive, HBase, Zookeeper, and so on) have many contributors from across the ecosystem.[6] Though Java code is most common, any programming language can be used with "streaming" to implement the "map" and "reduce" parts of the system.[7]
Contents

    1 History
    2 Architecture
        2.1 File systems
            2.1.1 Hadoop distributed file system
            2.1.2 Other file systems
        2.2 JobTracker and TaskTracker: the MapReduce engine
            2.2.1 Scheduling
                2.2.1.1 Fair scheduler
                2.2.1.2 Capacity scheduler
        2.3 Other applications
    3 Prominent users
        3.1 Yahoo!
        3.2 Facebook
        3.3 Other users
    4 Hadoop on Amazon EC2/S3 services
        4.1 Amazon Elastic MapReduce
    5 Industry support of academic clusters
    6 Running Hadoop in compute farm environments
        6.1 Grid engine integration
        6.2 Condor integration
    7 Commercially supported Hadoop-related products
        7.1 ASF's view on the use of "Hadoop" in product names
    8 Papers
    9 See also
    10 References
    11 Bibliography
    12 External links

##History

Hadoop was created by Doug Cutting and Mike Cafarella[8] in 2005. Cutting, who was working at Yahoo at the time,[9] named it after his son's toy elephant.[10] It was originally developed to support distribution for the Nutch search engine project.[11]

## Architecture
See also: Hadoop Distributed File System, Apache HBase, and MapReduce

Hadoop consists of the Hadoop Common package which provides filesystem and OS level abstractions, a MapReduce engine (either MapReduce or YARN) and the Hadoop Distributed File System (HDFS). The Hadoop Common package contains the necessary Java ARchive (JAR) files and scripts needed to start Hadoop. The package also provides source code, documentation and a contribution section that includes projects from the Hadoop Community.[citation needed]

For effective scheduling of work, every Hadoop-compatible file system should provide location awareness: the name of the rack (more precisely, of the network switch) where a worker node is. Hadoop applications can use this information to run work on the node where the data is, and, failing that, on the same rack/switch, reducing backbone traffic. HDFS uses this method when replicating data to try to keep different copies of the data on different racks. The goal is to reduce the impact of a rack power outage or switch failure, so that even if these events occur, the data may still be readable.[12]
Hadoop cluster
A multi-node Hadoop cluster

A small Hadoop cluster will include a single master and multiple worker nodes. The master node consists of a JobTracker, TaskTracker, NameNode and DataNode. A slave or worker node acts as both a DataNode and TaskTracker, though it is possible to have data-only worker nodes and compute-only worker nodes. These are normally used only in nonstandard applications.[13] Hadoop requires Java Runtime Environment (JRE) 1.6 or higher. The standard start-up and shutdown scripts require Secure Shell (ssh) to be set up between nodes in the cluster.[14]

In a larger cluster, the HDFS is managed through a dedicated NameNode server to host the file system index, and a secondary NameNode that can generate snapshots of the namenode's memory structures, thus preventing file-system corruption and reducing loss of data. Similarly, a standalone JobTracker server can manage job scheduling. In clusters where the Hadoop MapReduce engine is deployed against an alternate file system, the NameNode, secondary NameNode and DataNode architecture of HDFS is replaced by the file-system-specific equivalent.
File systems
Hadoop distributed file system

HDFS is a distributed, scalable, and portable file system written in Java for the Hadoop framework. Each node in a Hadoop instance typically has a single namenode; a cluster of datanodes form the HDFS cluster. The situation is typical because each node does not require a datanode to be present. Each datanode serves up blocks of data over the network using a block protocol specific to HDFS. The file system uses the TCP/IP layer for communication. Clients use Remote procedure call (RPC) to communicate between each other. HDFS stores large files (typically gigabytes to terabytes[15]), across multiple machines. It achieves reliability by replicating the data across multiple hosts, and hence does not require RAID storage on hosts. With the default replication value, 3, data is stored on three nodes: two on the same rack, and one on a different rack. Data nodes can talk to each other to rebalance data, to move copies around, and to keep the replication of data high. HDFS is not fully POSIX compliant, because the requirements for a POSIX file system differ from the target goals for a Hadoop application. The tradeoff of not having a fully POSIX-compliant file system is increased performance for data throughput and support for non-POSIX operations such as Append.[16]

HDFS added high-availability capabilities, as announced for release 2.0 in May 2012[17] allowing the main metadata server (the NameNode) to be failed over manually to a backup in the event of failure. Automatic fail-over is being developed as well. Additionally, the file system includes what is called a secondary namenode, which misleads some people into thinking[citation needed] that when the primary namenode goes offline, the secondary namenode takes over. In fact, the secondary namenode regularly connects with the primary namenode and builds snapshots of the primary namenode's directory information, which is then saved to local or remote directories. These checkpointed images can be used to restart a failed primary namenode without having to replay the entire journal of file-system actions, then to edit the log to create an up-to-date directory structure. Because the namenode is the single point for storage and management of metadata, it can be a bottleneck for supporting a huge number of files, especially a large number of small files. HDFS Federation is a new addition that aims to tackle this problem to a certain extent by allowing multiple name spaces served by separate namenodes.

An advantage of using HDFS is data awareness between the job tracker and task tracker. The job tracker schedules map or reduce jobs to task trackers with an awareness of the data location. An example of this would be if node A contained data (x,y,z) and node B contained data (a,b,c). Then the job tracker will schedule node B to perform map or reduce tasks on (a,b,c) and node A would be scheduled to perform map or reduce tasks on (x,y,z). This reduces the amount of traffic that goes over the network and prevents unnecessary data transfer. When Hadoop is used with other file systems this advantage is not always available. This can have a significant impact on job-completion times, which has been demonstrated when running data-intensive jobs.[18]

HDFS was designed for mostly immutable files[16] and may not be suitable for systems requiring concurrent write operations.

Another limitation of HDFS is that it cannot be mounted directly by an existing operating system. Getting data into and out of the HDFS file system, an action that often needs to be performed before and after executing a job, can be inconvenient. A Filesystem in Userspace (FUSE) virtual file system has been developed to address this problem, at least for Linux and some other Unix systems.

File access can be achieved through the native Java API, the Thrift API to generate a client in the language of the users' choosing (C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, Smalltalk, and OCaml), the command-line interface, or browsed through the HDFS-UI webapp over HTTP.
Other file systems

By May 2011, the list of supported file systems included:

    HDFS: Hadoop's own rack-aware file system.[19] This is designed to scale to tens of petabytes of storage and runs on top of the file systems of the underlying operating systems.
    Amazon S3 file system. This is targeted at clusters hosted on the Amazon Elastic Compute Cloud server-on-demand infrastructure. There is no rack-awareness in this file system, as it is all remote.
    MapR's maprfs file system. This system provides inherent high availability, transactionally correct snapshots and mirrors while offering higher scaling than HDFS while giving higher performance. Maprfs is available as part of the MapR distribution and as a native option on Elastic Map Reduce from Amazon's web services, as well as on Google Compute Engine.
    CloudStore (previously Kosmos Distributed File System), which is rack-aware.
    FTP File system: this stores all its data on remotely accessible FTP servers.
    Read-only HTTP and HTTPS file systems.

Hadoop can work directly with any distributed file system that can be mounted by the underlying operating system simply by using a file:// URL; however, this comes at a price: the loss of locality. To reduce network traffic, Hadoop needs to know which servers are closest to the data; this is information that Hadoop-specific file system bridges can provide.

Out-of-the-box, this includes Amazon S3, and the CloudStore filestore, through s3:// and kfs:// URLs directly.

A number of third-party file system bridges have also been written, none of which are currently in Hadoop distributions.

    In 2009 IBM discussed running Hadoop over the IBM General Parallel File System.[20] The source code was published in October 2009.[21]
    In April 2010, Parascale published the source code to run Hadoop against the Parascale file system.[22]
    In April 2010, Appistry released a Hadoop file system driver for use with its own CloudIQ Storage product.[23]
    In June 2010, HP discussed a location-aware IBRIX Fusion file system driver.[24]
    In May 2011, MapR Technologies, Inc. announced the availability of an alternative file system for Hadoop, which replaced the HDFS file system with a full random-access read/write file system, with advanced features like snaphots and mirrors, and get rid of the single point of failure issue of the default HDFS NameNode.

JobTracker and TaskTracker: the MapReduce engine
Main article: MapReduce

Above the file systems comes the MapReduce engine, which consists of one JobTracker, to which client applications submit MapReduce jobs. The JobTracker pushes work out to available TaskTracker nodes in the cluster, striving to keep the work as close to the data as possible. With a rack-aware file system, the JobTracker knows which node contains the data, and which other machines are nearby. If the work cannot be hosted on the actual node where the data resides, priority is given to nodes in the same rack. This reduces network traffic on the main backbone network. If a TaskTracker fails or times out, that part of the job is rescheduled. The TaskTracker on each node spawns off a separate Java Virtual Machine process to prevent the TaskTracker itself from failing if the running job crashes the JVM. A heartbeat is sent from the TaskTracker to the JobTracker every few minutes to check its status. The Job Tracker and TaskTracker status and information is exposed by Jetty and can be viewed from a web browser.

If the JobTracker failed on Hadoop 0.20 or earlier, all ongoing work was lost. Hadoop version 0.21 added some checkpointing to this process; the JobTracker records what it is up to in the file system. When a JobTracker starts up, it looks for any such data, so that it can restart work from where it left off.

Known limitations of this approach are:

    The allocation of work to TaskTrackers is very simple. Every TaskTracker has a number of available slots (such as "4 slots"). Every active map or reduce task takes up one slot. The Job Tracker allocates work to the tracker nearest to the data with an available slot. There is no consideration of the current system load of the allocated machine, and hence its actual availability.
    If one TaskTracker is very slow, it can delay the entire MapReduce job - especially towards the end of a job, where everything can end up waiting for the slowest task. With speculative execution enabled, however, a single task can be executed on multiple slave nodes.

Scheduling

By default Hadoop uses FIFO, and optional 5 scheduling priorities to schedule jobs from a work queue.[25] In version 0.19 the job scheduler was refactored out of the JobTracker, and added the ability to use an alternate scheduler (such as the Fair scheduler or the Capacity scheduler).[26]
Fair scheduler

The fair scheduler was developed by Facebook. The goal of the fair scheduler is to provide fast response times for small jobs and QoS for production jobs. The fair scheduler has three basic concepts.[27]

    Jobs are grouped into Pools.
    Each pool is assigned a guaranteed minimum share.
    Excess capacity is split between jobs.

By default, jobs that are uncategorized go into a default pool. Pools have to specify the minimum number of map slots, reduce slots, and a limit on the number of running jobs.
Capacity scheduler

The capacity scheduler was developed by Yahoo. The capacity scheduler supports several features which are similar to the fair scheduler.[28]

    Jobs are submitted into queues.
    Queues are allocated a fraction of the total resource capacity.
    Free resources are allocated to queues beyond their total capacity.
    Within a queue a job with a high level of priority will have access to the queue's resources.

There is no preemption once a job is running.
Other applications

The HDFS file system is not restricted to MapReduce jobs. It can be used for other applications, many of which are under development at Apache. The list includes the HBase database, the Apache Mahout machine learning system, and the Apache Hive Data Warehouse system. Hadoop can in theory be used for any sort of work that is batch-oriented rather than real-time, that is very data-intensive, and able to work on pieces of the data in parallel. As of October 2009, commercial applications of Hadoop[29] included:

    Log and/or clickstream analysis of various kinds
    Marketing analytics
    Machine learning and/or sophisticated data mining
    Image processing
    Processing of XML messages
    Web crawling and/or text processing
    General archiving, including of relational/tabular data, e.g. for compliance

Prominent users
Yahoo!

On February 19, 2008, Yahoo! Inc. launched what it claimed was the world's largest Hadoop production application. The Yahoo! Search Webmap is a Hadoop application that runs on a more than 10,000 core Linux cluster and produces data that is used in every Yahoo! Web search query.[30]

There are multiple Hadoop clusters at Yahoo! and no HDFS file systems or MapReduce jobs are split across multiple datacenters. Every Hadoop cluster node bootstraps the Linux image, including the Hadoop distribution. Work that the clusters perform is known to include the index calculations for the Yahoo! search engine.

On June 10, 2009, Yahoo! made the source code of the version of Hadoop it runs in production available to the public.[31] Yahoo! contributes all the work it does on Hadoop to the open-source community. The company's developers also fix bugs, provide stability improvements internally and release this patched source code so that other users may benefit from their effort.
Facebook

In 2010 Facebook claimed that they had the largest Hadoop cluster in the world with 21 PB of storage.[32] On July 27, 2011 they announced the data had grown to 30 PB.[33] On June 13, 2012 they announced the data had grown to 100 PB.[34] On November 8, 2012 they announced the warehouse grows by roughly half a PB per day.[35]
Other users

Besides Facebook and Yahoo!, many other organizations are using Hadoop to run large distributed computations. Some of the notable users include:[5]