omoidebase
==========

Share your memory based on location.

Developed at Couchbase Lite Hackathon at Sept 7th, 2014 in Tokyo, by team 'CouchMemories'.
Our team members worked really well together, as a result, we got the 1st prize :)

Omoidebase is an iOS application which uses Couchbase Lite and SyncGateway.
The system managed channels based on places in order to share memories among people who have visited the place.

Couchbase Server and SyncGateway
================================
You need a SyncGateway instance and Couchbase Server (or Walrus), with a bucket named 'omoidebase'.

How to use SyncGateway
=======================

A SyncGateway configuration file is included at omoidebase/sync-gateway/config.json
You can start SyncGateway specifying this file:

`
bin/sync_gateway config.json
`

There are some 'place' documents under sync-gateway/places. You can add these document by:

`
curl -XPUT -H "Content-Type: application/json" -d @ryokan.json http://localhost:4985/omoidebase/E3F58FBF-6C5F-4410-AAA2-F5C666DFE958
`

