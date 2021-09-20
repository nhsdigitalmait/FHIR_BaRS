@echo off
rem
rem invokes execution of tkw-x in autotest mode to test BaRS Providers
rem
docker-compose -f docker-compose_consumer_simulator.yml run --rm tkw_bars_consumer_simulator %*
