FROM alpine

ENV ADMIN_PUBKEY ""
ENV ANON_READ yes
RUN apk add --no-cache git git-daemon gitolite openssh-server
RUN echo PasswordAuthentication no >>/etc/ssh/sshd_config &&\
        echo ChallengeResponseAuthentication no >>/etc/ssh/sshd_config &&\
        echo AllowUsers git >>/etc/ssh/sshd_config &&\
        passwd -u git

COPY entrypoint.sh /entrypoint.sh

EXPOSE 22 9418
VOLUME /var/lib/git /etc/ssh
ENTRYPOINT /entrypoint.sh
