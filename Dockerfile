FROM docker:1.12.5
# Source: https://github.com/docker-library/docker/blob/2e8569cf5c665ef955855e95be475f52a55c0720/1.8/dind/Dockerfile

# https://github.com/docker/docker/blob/master/project/PACKAGERS.md#runtime-dependencies
RUN apk add --update \
		btrfs-progs \
		e2fsprogs \
		iptables \
		xz \
		xfsprogs \
	&& rm -rf /var/cache/apk/*

# TODO aufs-tools

ENV DIND_COMMIT 4e899d64e020a67ca05f913d354aa8d99a341a7b

COPY dockerd-entrypoint.sh /usr/local/bin/
COPY dind /usr/local/bin/
COPY docker-login.sh /usr/local/bin/
COPY docker-pull.sh /usr/local/bin/
COPY docker-push.sh /usr/local/bin/
COPY docker-tag.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/dind \
	&& chmod +x /usr/local/bin/dockerd-entrypoint.sh \
	&& chmod +x /usr/local/bin/docker-login.sh \
	&& chmod +x /usr/local/bin/docker-pull.sh \
	&& chmod +x /usr/local/bin/docker-push.sh \
	&& chmod +x /usr/local/bin/docker-tag.sh \
	&& chmod 777 /var/run/

VOLUME /var/lib/docker
EXPOSE 2375

USER 0

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
CMD []
