#!/bin/sh

if [ ! -d  /var/lib/git/.ssh ]; then
    # Initialize gitolite
    admin_pubkey_file=/tmp/admin.pub
    printf "%s" "$ADMIN_PUBKEY" >$admin_pubkey_file
    su - git -c "gitolite setup -pk $admin_pubkey_file"
    rm $admin_pubkey_file
fi

if [ "x$ANON_READ" = "xyes" ]; then
    su - git -c "git daemon --export-all --base-path=/var/lib/git/repositories &"
fi

ssh-keygen -A

exec /usr/sbin/sshd -D
