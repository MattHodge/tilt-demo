# tilt-demo

1. Setup a kind cluster
2. Run `docker image prune` (to avoid free space issues)
3. Run `./demo.sh` before demo starts 

# Demo Script

## Initial Demo

* Show IDE / repo structure
* Show `Tiltfile`
* `tilt up`
* Show namespace created via kubectl
* Explain `intake` service
* Look at how to build the `intake` service locally (docker)
* Add `intake` into Tilt
* Use Insomnia to send some HTTP Requests
* Make a Go code change, manually trigger container build
* Activate + Explain LiveSync
* Make `intake` code change, use livesync and see the speed difference
* Enable + explain `emitter` service, show in `Tiltfile`
* Show Python live sync
* Can run multiple services of multiple languages

## Database Workflow Use Case

* Enable MySql
* Check connection via IDE
* Enable the `intake-db-workflows`
* Migrate the db, check the new table created in IDE
* Change go code for intake to write to the db
* Check the table in the db, reset the db
