#!/bin/bash
#
# invokes execution of tkw-x in autotest mode to test BaRS providers
#
docker-compose -f docker-compose_consumer_simulator.yml run --rm tkw_bars_consumer_simulator $*
