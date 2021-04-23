My docker stack deploy:

```yaml
---
version: '3.2'

services:
  web:
    image: yitsushi/dokuwiki:2020-07-29-patch1
    networks:
      - traefik-public
    ports:
      - 80
    volumes:
      - type: volume
        source: nfs-data
        target: /dokuwiki/data
        volume:
          nocopy: true
      - type: volume
        source: nfs-conf
        target: /dokuwiki/conf
        volume:
          nocopy: true
      - type: volume
        source: nfs-plugins
        target: /dokuwiki/lib/plugins
        volume:
          nocopy: true
      - type: volume
        source: nfs-tpl
        target: /dokuwiki/lib/tpl
        volume:
          nocopy: true
    deploy:
      labels:
        - "traefik.enable=true"
        - "traefik.http.routers.wiki-ci-router.rule=Host(`my.domain.tld`)"
        - "traefik.http.services.wiki-ci-service.loadbalancer.server.port=80"
        - "traefik.http.routers.wiki-ci-router.tls=true"
        - "traefik.http.routers.wiki-ci-router.tls.certresolver=cloudflare"
        - "traefik.docker.network=traefik-public"

volumes:
  nfs-data:
    driver_opts:
      type: "nfs"
      o: "nfsvers=4,addr=nfs.server.addr,nolock,soft,rw"
      device: ":/my.domain.tld/data"
  nfs-conf:
    driver_opts:
      type: "nfs"
      o: "nfsvers=4,addr=nfs.server.addr,nolock,soft,rw"
      device: ":/my.domain.tld/conf"
  nfs-plugins:
    driver_opts:
      type: "nfs"
      o: "nfsvers=4,addr=nfs.server.addr,nolock,soft,rw"
      device: ":/my.domain.tld/plugins"
  nfs-tpl:
    driver_opts:
      type: "nfs"
      o: "nfsvers=4,addr=nfs.server.addr,nolock,soft,rw"
      device: ":/my.domain.tld/tpl"

networks:
  traefik-public:
    external: true
```
