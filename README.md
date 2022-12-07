# pam_limit_ssh

This PAM module limits the number of active SSH sessions per user.  It does
this by looking at the active SSH connections and denying new sessions for a
user when a max has been met.

## Installation

Place the file `pam_limit_ssh.so` in the directory `/usr/lib64/security/pam_limit_ssh.so`

```
cp pam_limit_ssh.so /usr/lib64/security/pam_limit_ssh.so
chown root: /usr/lib64/security/pam_limit_ssh.so
chmod 755 /usr/lib64/security/pam_limit_ssh.so
```

and add the line to the top of `/etc/pam.d/sshd` config file:

```
auth       required     pam_limit_ssh.so max=5
```

Instead of an auth, it could be required by an account or session:
```
account    required     pam_limit_ssh.so max=10
```

```
session    required     pam_limit_ssh.so max=6 sshd=/usr/sbin/sshd
```

It's a good idea to only include the `pam_limit_ssh.so` once so the checks are not repeated per login.

## Settings

The settings for this module are:

- max= Maximum concurrent SSH connections
- sshd= The path of the sshd executable if different than the default `/usr/sbin/sshd`

## Verification of functionality

```
$ sudo tail -f /var/log/messages | grep pam_limit_ssh
Dec  7 19:16:01 centos7 pam_test: pam_limit_ssh(check_user:auth): user schou, current 4, max 5
Dec  7 19:16:01 centos7 pam_test: pam_limit_ssh(check_user:account): user schou, current 4, max 10
```
