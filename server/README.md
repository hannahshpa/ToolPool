# Backend Sever Docs

## Setup

### **Base setup**

For request authentication, we need to create a RSA private/public keyfile. To do so:

1. `cd` into /server directory
2. Create the private key file with command:
   `ssh-keygen -t rsa -b 4096 -m PEM -f privateKey.key`
   - don't add any passphrase
3. Create the paired public key file with command:
   ` openssl rsa -in privateKey.key -pubout -outform PEM -out privateKey.key.pub`

This keyfile will be used for both dockerized/ local dev setup.

For AWS setup, we need to create a credentials file with AWS keys

1. `cd` into your home directory, `cd ~`
2. Create a aws directory, `mkdir .aws`
3. `cd` into the directory, `cd .aws`
4. create a 'credentials' file, `touch credentials`
5. Open the credentials file, and add the following:

```
[default]
aws_access_key_id = <assigned aws access key>
aws_secret_access_key = <assigned secret access key>
```

- Just type the literal \[default] at the top, it's syntactical
- Put in the assigned keys within <> tags

6. AWS keys are set to go, they'll automatically be imported & used by the AWS SDK

### **Client setup**

For simply building the server, build and run the docker-compose network:

    docker-compose build && docker-compose up

This may take up to 10 minutes

### **Development setup**

For development, leave docker-compose running for the postgres DB with:

    docker-compose build && docker-compose up

Then within /server directory, build & run the server with:

    vapor build && vapor run

---

## API Documentation

### Signup

route: POST /signup

required header: `None`

required request parameters:

| Key         | Value  |
| ----------- | ------ |
| email       | String |
| password    | String |
| name        | String |
| phoneNumber | String |

required request body: `None`

Return Value:

- Success: 200 status, "success"

---

### Login

route: POST /login

required header: `None`

required request parameters: `None`

required request body:

```
{
    "email": <String>,
    "password": <String>
}
```

Return Value:

- Success: 200 status, "< AuthToken >"
  - note that the token expires after 60 minutes

---

### Image Upload

route: POST /uploadImage

required header:
| Key | Value |
|----------------|--------------------|
| Authentication | Bearer < AuthToken > |

required request paramters: `None`

required request body:

```
{
   "toolId" : <int>,
   "imageFile": <png | jpg | webp | heic File>
}
```

- note that the owner of the tool has to match the user in authToken

Return Value:

- Success: 200 status

---

### GraphQL API

route: POST /graphql

required header:
| Key | Value |
|----------------|--------------------|
| Authentication | Bearer < AuthToken > |

required request parameters: `None`

required request body: < GQL query >

Return Value:

- Success: 200 status,

```
   {
       "data": {
           <Requested Data>
       }
   }
```

---

## Trouble Shooting

- Current modifications in the postres schema may fail to update the schemas in the dockerized postgres. The new password field in the users table has been a common problem. To fix this:

  1. Run the docker containers
  2. Look for the container id of the db, by running

     `docker ps`

  3. Ssh into the container with

     `docker exec -it <containerId> psql -U postgres`

  4. Run the sql command:

     `ALTER TABLE users ADD COLUMN password VARCHAR(64) NOT NULL DEFAULT 'default’;`

  5. Quit and exit ssh:

     `\q`
