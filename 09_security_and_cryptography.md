# Security and Cryptography

## Exercises

1. **Entropy.**
    1. Suppose a password is chosen as a concatenation of four lower-case
       dictionary words, where each word is selected uniformly at random from a
       dictionary of size 100,000. An example of such a password is
       `correcthorsebatterystaple`. How many bits of entropy does this have?

       ```
       dic_size = 100 000 = 1e5
       nb_poss = dic_size^4 = 1e20
       Entropy = log_2(nb_poss) = log_10(nb_poss)/log_10(2) = 66 bits
       ```

    1. Consider an alternative scheme where a password is chosen as a sequence
       of 8 random alphanumeric characters (including both lower-case and
       upper-case letters). An example is `rg8Ql34g`. How many bits of entropy
       does this have?

       ```
       dic_size = 26*2 + 10 = 62
       nb_poss = dic_size^8 = 2e14
       Entropy = 48 bits
       ```

    1. Which is the stronger password?
    1. Suppose an attacker can try guessing 10,000 passwords per second. On
       average, how long will it take to break each of the passwords?
       ```
       1st solution has higher entropy thus is stronger.
       1st : ~300 hundred million years
       2nd : ~600 years
       ```
2. **Cryptographic hash functions.** Download a Debian image from a
   [mirror](https://www.debian.org/CD/http-ftp/) (e.g. [from this Argentinean
   mirror](http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/)).
   Cross-check the hash (e.g. using the `sha256sum` command) with the hash
   retrieved from the official Debian site (e.g. [this
   file](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS)
   hosted at `debian.org`, if you've downloaded the linked file from the
   Argentinean mirror).

```bash
# download the Argentinean mirror of 11.5.0
curl http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/debian-11.5.0-amd64-netinst.iso -o debian-11.5.0-amd64-netinst.iso
# download the shasum of debian-11.5.0-amd64-netinst.iso from the official debian site
curl https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS | head -1 > debian_sha256sum.txt
# compute shasum of downloaded argentinian version
sha256sum debian-11.5.0-amd64-netinst.iso > debian_sha256sum_ar.txt
# compare both version
cmp debian_sha256sum.txt debian_sha256sum_ar.txt
# verify that the exit status is 0, thus no differences between the 2 files
echo $?
```

3. **Symmetric cryptography.** Encrypt a file with AES encryption, using
   [OpenSSL](https://www.openssl.org/): `openssl aes-256-cbc -salt -in {input
   filename} -out {output filename}`. Look at the contents using `cat` or
   `hexdump`. Decrypt it with `openssl aes-256-cbc -d -in {input filename} -out
   {output filename}` and confirm that the contents match the original using
   `cmp`.

```bash
openssl aes-256-cbc -salt -in debian_sha256sum.txt -out encrypted_shasum
cat encrypted_shasum
openssl aes-256-cbc -d -in encrypted_shasum -out decrypted_shasum
cmp decrypted_shasum debian_sha256sum.txt
echo $?
```

4. **Asymmetric cryptography.**
    1. Set up [SSH keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2) on a computer you have access to (not Athena,
       because Kerberos interacts weirdly with SSH keys). Make sure
       your private key is encrypted with a passphrase, so it is protected at
       rest.
    1. [Set up GPG](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages)
    2. Send Anish an encrypted email ([public key](https://keybase.io/anish)).
    3. Sign a Git commit with `git commit -S` or create a signed Git tag with
       `git tag -s`. Verify the signature on the commit with `git show
       --show-signature` or on the tag with `git tag -v`.
