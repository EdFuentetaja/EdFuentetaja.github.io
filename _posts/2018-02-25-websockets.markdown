---
title:  "Notes on WebSockets"
date:   2018-02-25 00:00:00 +0800
categories: Software
excerpt: "A showcase of simple client and server WebSocket implementations on C++, C# and javascript. Also showing how to configure wss and client authentication."
header:
  image: "golden_record_cropped.jpg"
---

I've been recently considering different options for the implementation of a communication layer between a server and multiple clients over a private network. These are the key factors I'm looking for:

* A modern but stable framework.
* Minimal overload, allowing for efficient transmission of binary data as well as text-based messages.
* Full duplex, allowing clients and servers to push unrequested messages.
* Secure, allowing for authentication of servers and clients.
* Multiplatform, being the focus so far on C++, C# and javascript but with an eye on Java and Android.

Websockets seems to cover all these needs. I chose the popular [websocketpp][websocketpp] (version 0.7.0) for the C++ implementation and [websocket-sharp][websocket-sharp] (February 2018 code, no releases yet) for C# on .NET. Both implementations look reliable and came with some ready examples.

The "normal" unsecured WebSocket connections (ws://) are very simple and work out of the box mostly with no problems. The secured version (wss://) making use of the SSL layer is a different story. I lost track of all the little issues that kept creeping and the countless pages I visited on stackoverflow and everywhere else. I apologize if I don't give due credit to everyone. All this confusion is the reason why I have decided to make this notes public. Hopefully they will be useful to someone else.

## Notes on the C++ implementation

Big kudos to **Peter Thorson** for his [websocketpp][websocketpp]. Things I like: it comes as a header only library, it's multiplatform and even allows to choose between using a C11 compiler or the Boost libraries. Things I didn't like so much are the coding examples, in my opinion confusing and bloated; I had to modify them extensively. I didn't like the fact neither that the library swallows the error codes from OpenSSL which are critical for troubleshooting the inevitable errors that are going to happen with certificates, ciphers and what not (this fact is already reported to the author). And particularly I didn't like how the client came out. I was looking for a way to be able to switch easily between secure and unsecure connections but I haven't been able to achieve this. I'd like to define in a configuration file whether the connection should be secure or not and have the same code to handle the communication once it is established but at this moment I don't think this is possible. One'll need to add additional logic on the application layer.

There are two C++ projects in the repository: _WebSocketCPPClient_ and _WebSocketCPPServer_, including one common utility file that process PFX files. I prefer to use PFX files rather than having the private key file in the open. PFX files are encrypted and even though the password in the end needs to be compiled into the application at least it'd make hacking of the certificates more time consuming for the bad guys.

Regarding the certificate validation, note that I'm not particularly interested in using the Microsoft standard way of installing trusted root certificates in Windows machines. I prefer to have a folder in the computer and indicate the OpenSSL layer where it is, this approach should work on any platform.

## Notes on the C# implementation

Credit here goes to **sta** for this excellent implementation of WebSockets on C#. Both client and server example code is clean and simple to understand and addapt. I only made minimal changes to enable client and server certificate validation. I liked very much that the server comes with the infrastructure to associate _behaviors_ (I understand them more like _services_) to specific paths, so it's very easy to segregate different functional components running all in the same server instance.

## Notes on Javascript

This is by far the easiest. WebSockets are these days native to javascript so a few lines of code are enough to have a running client on the browser. I'm not interested on a WebSocket server running on Javascript but if I was, I'd look into [Node.js][Node.js].

I was also not surprised to learn that javascript doesn't support client certificates. I didn't look into this very much but some of the references I found seem to suggest making javascript talk to some sort of WebSocket proxy that runs locally and that takes care of sending the certificate to the server upon connection.

As far as the server certificate validation, this is taken care by the browser and therefore it would require that the server certificate chain is trusted by the browser. For Windows computers it means that if you are using a self-signed certificate for testing, it needs to be added to the _Trusted Root Certification Authorities_ on the _Microsoft Management Console_.

## Certificate generation using OpenSSL

It seems that I only get into SSL every few years. As a cheat sheet I'm including here all the commands required to generate certificates, self-signed certificates and other supporting files that are needed during the client and servers WebSockets testing:

### To generate the server self-signed certificate and the server private key in pem format

Modern browsers require the that _subjectAltName_ of the server certificate matches the hostname the client is trying to connect to, not just the _CN (Common Name)_. First locate your OpenSSL _openssl.cnf_ file, it needs to be modified. So far this is the only way I've found. See [this entry][s1] in stackoverflow and [this one][s2] also. I copied to the certificate_server folder in the GitHub repository the config file that I was using. If you are just using the IP address of the server like me, enter it at the bottom of the config file under the **IP.1** property. If you access your server with a host name enter it instead using a **DNS.1** property.

Then run this command:

`openssl req -newkey rsa:2048 -nodes -keyout server_private_key_do_not_distribute_this_file.pem -x509 -out server.pem -days 10000 -config openssl.cnf`

Use the same _subjectAltName_ when you are prompted for the Common Name (CN).

### To see the content of a pem certificate, f.i. the one just generated

`openssl.exe x509 -in server.pem -noout -text`

You should see something like this:

```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            df:75:c3:9c:b7:d1:4f:31
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=SG, ST=Singapore, L=Singapore, O=Test, OU=Server, CN=127.0.0.1/emailAddress=server@xxx.com
        Validity
            Not Before: Feb 17 18:37:29 2018 GMT
            Not After : Jul  5 18:37:29 2045 GMT
        Subject: C=SG, ST=Singapore, L=Singapore, O=Test, OU=Server, CN=127.0.0.1/emailAddress=server@xxx.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:de:25:ca:8a:e4:d1:5d:2d:5a:2e:99:db:04:70:
                    ...
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier:
                17:F6:61:FE:BA:A0:9B:9A:B8:65:4A:BC:6B:BA:CA:8C:A2:B6:CA:14
            X509v3 Authority Key Identifier:
                keyid:17:F6:61:FE:BA:A0:9B:9A:B8:65:4A:BC:6B:BA:CA:8C:A2:B6:CA:14

            X509v3 Basic Constraints:
                CA:TRUE
            X509v3 Subject Alternative Name:
                IP Address:127.0.0.1
    Signature Algorithm: sha256WithRSAEncryption
         a6:63:63:a7:20:ba:0b:11:68:d2:eb:65:eb:55:a1:4e:54:02:
         ...
```

Notice the _CN_ and _Subject Alternative Name_ entries.

### To export the certificate together with the private key into PCKS12 format

`openssl pkcs12 -export -out server.pfx -inkey server_private_key_do_not_distribute_this_file.pem -in server.pem`

The output file _server.pfx_ combines both certificate and private key encrypted. I like this format because prevents having private keys in the open. This command will prompt for the export password, the same we need to enter in the code to decrypt the pfx file and recover certificate and private key. For this example the password I chose is _secretpassword_. You will find it it in the code.

### To see the content of the pfx file

`openssl pkcs12 -info -in server.pfx`

### To generate a dh file

They are used by Diffie-Hellman cyphers. They take a long time to produce so I prefer to generate offline, although I admit I don't know very much what's going on here.

`openssl dhparam -out dh.pem 2048`

### To generate the client certificate signed by the server

Generate first the client private key:

`openssl.exe genrsa -out client_private_key_do_not_distribute_this_file.pem 2048`

Generate a sign request for the client certificate (client.csr):

`openssl.exe req -new -key client_private_key_do_not_distribute_this_file.pem -out client.csr -days 10000`

Produce a client certificate (client.pem) signed with the server certificate:

`openssl.exe ca -policy policy_anything -keyfile server_private_key_do_not_distribute_this_file.pem -cert server.pem -out client.pem -infiles client.csr`

The client.pem is the client certificate. Export this file to the PCKS12 format as explained before

### To promote the _server.pem_ to certifying authority on the server

Get the subject hash of the server certificate:

`openssl.exe x509 -in server.pem -noout -subject_hash`

Now, to use the server certificate as a CA on the server side (so it can validate the client certificate signed by it) we have to copy the server certificate to our CA folder, using as file name the subject hash and as extension **.0**

### To verify that the client certificate is valid

`openssl.exe verify -verbose -CApath <CA directory> client.pem`

That should be able to generate all the files I'm using throughout the examples. Next are a couple of commands that are very useful for troubleshooting

### To test the server you can run openssl as a debug client

`openssl.exe s_client -host 127.0.0.1 -port 8080 -cert client.pem -key client_private_key_do_not_distribute_this_file.pem`

### And To test the client, run openssl as a debug server

`openssl.exe s_server -accept 8080 -cert server.pem -key server_private_key_do_not_distribute_this_file.pem -Verify`

That's all so far. I added plenty of comments to the source code, I hope they are clear enough.

[websocketpp]:    https://github.com/zaphoyd/websocketpp
[websocket-sharp]:    https://github.com/sta/websocket-sharp
[Node.js]:    https://nodejs.org/en/
[s1]:         https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
[s2]:         https://superuser.com/questions/1202498/create-self-signed-certificate-with-subjectaltname-to-fix-missing-subjectaltnam/1202506#1202506