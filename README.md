# mgw

Simple dev environment to stand up a two-datacenter federated consul cluster.

Roughly speaking:

1. Checkout `https://github.com/hashicorp/consul`, switch to the `wan-mgw` branch and run `make dev-docker`.
2. In the `mgw` project run `make up-pri` to bring up the primary datacenter
3. Check progress with `docker-compose logs -f dc1-server1` when it stabilizes...
4. Run `make up` to bring up the rest.
5. Check progress with `docker-compose logs -f dc1-server1` and `docker-compose logs -f dc2-server1`.
6. Check what each datacenter thinks is the WAN with `./consul.sh dc1 members -wan` and `./consul.sh dc2 members -wan`.

