
## <a name="resource-admin_text">Admin Texts</a>

Stability: `prototype`

An admin text is a text for an admin area

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of the Admin Text | `42` |

### <a name="link-GET-admin_text-/admin_texts">Admin Texts List</a>

Show the admin texts for the tags.

```
GET /admin_texts
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **tags** | *array* |  | `[null]` |


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//admin_texts
 -G \
  -d tags[]=
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-chat">Chat</a>

Stability: `prototype`

An chat is a virtual space to talk about something with someone.

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | the message creation date and time | `"2015-01-01T12:00:00Z"` |
| **id** | *integer* | unique identifier of the chat | `42` |
| **message** | *string* | the message that the user is sending | `"example"` |
| **room_id** | *integer* | the id of the room that the chat belongs to | `42` |
| **user_id** | *integer* | the id of the user that is sending a message through the chat | `42` |

### <a name="link-GET-chat-/chat/{(%23%2Fdefinitions%2Fchat%2Fdefinitions%2Fidentity)}">Chat Info</a>

Info for existing chat.

```
GET /chat/{chat_id}
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//chat/$CHAT_ID
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-POST-chat-/chat">Chat Create</a>

Create a new chat message

```
POST /chat
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **message** | *string* | the message that the user is sending | `"example"` |
| **room_id** | *integer* | unique identifier of the room | `42` |


#### Curl Example

```bash
$ curl -n -X POST https://production-room-api.herokuapp.com//chat \
  -d '{
  "room_id": 42,
  "message": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```


## <a name="resource-error">Error</a>

Stability: `prototype`

An error represents a failed action in the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *string* | unique identifier of error<br/> **pattern:** `^\w+$` | `"example"` |
| **message** | *string* | message of error | `"example"` |

### <a name="link-GET-error-/errors/{(%23%2Fdefinitions%2Ferror%2Fdefinitions%2Fidentity)}">Error Info</a>

Info for existing error.

```
GET /errors/{error_id}
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//errors/$ERROR_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "example",
  "message": "example"
}
```


## <a name="resource-faq">Faq</a>

Stability: `prototype`

A faq is a series of frequently asked questions paired with answers that provides basic information

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **answer** | *string* | an answer of a question of the faq | `"example"` |
| **id** | *integer* | unique identifier of the faq | `42` |
| **question** | *string* | a question of the faq | `"example"` |

### <a name="link-GET-faq-/faq">Faq List</a>

List all faqs, that is, all faq questions and answers

```
GET /faq
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//faq
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-feedback">Feedback</a>

Stability: `prototype`

A feedback is _________

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | the email of the user that sends the feedback | `"example"` |
| **id** | *integer* | unique identifier of the feedback | `42` |
| **name** | *string* | the name of the user that sends the feedback | `"example"` |
| **negatives** | *string* | the negatives feedback from the user | `"example"` |
| **positives** | *string* | the positives feedback from the user | `"example"` |

### <a name="link-POST-feedback-/feedback">Feedback Create</a>

Create a new feedback

```
POST /feedback
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | the email of the user that sends the feedback | `"example"` |
| **id** | *integer* | unique identifier of the feedback | `42` |
| **name** | *string* | the name of the user that sends the feedback | `"example"` |
| **negatives** | *string* | the negatives feedback from the user | `"example"` |
| **positives** | *string* | the positives feedback from the user | `"example"` |


#### Curl Example

```bash
$ curl -n -X POST https://production-room-api.herokuapp.com//feedback \
  -d '{
  "id": 42,
  "name": "example",
  "email": "example",
  "positives": "example",
  "negatives": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```


## <a name="resource-mood">Mood</a>

Stability: `prototype`

A mood is the way the user feel at a particular time

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of the mood | `42` |
| **name** | *string* | a name of the mood | `"example"` |


## <a name="resource-org">Org</a>

Stability: `prototype`

An org is an entity such as a company or organization.

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **description** | *string* | a description of the org | `"example"` |
| **id** | *integer* | unique identifier of the org | `42` |
| **image** | *string* | an image such as an logo of the org | `"example"` |
| **members** | *nullable array* | the members list of the org | `null` |
| **name** | *string* | the name of the org | `"example"` |
| **rooms** | *nullable array* | the rooms list of the org | `null` |
| **user_id** | *integer* | the id of the user that created the org | `42` |

### <a name="link-GET-org-/org">Org List</a>

List of all the current user orgs

```
GET /org
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//org
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-POST-org-/org">Org Create</a>

Create a new org

```
POST /org
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **description** | *string* | a description of the org | `"example"` |
| **id** | *integer* | unique identifier of the org | `42` |
| **image** | *string* | an image such as an logo of the org | `"example"` |
| **name** | *string* | the name of the org | `"example"` |
| **user_id** | *integer* | the id of the user that created the org | `42` |


#### Curl Example

```bash
$ curl -n -X POST https://production-room-api.herokuapp.com//org \
  -d '{
  "id": 42,
  "user_id": 42,
  "name": "example",
  "description": "example",
  "image": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```

### <a name="link-GET-org-/org/{(%23%2Fdefinitions%2Forg%2Fdefinitions%2Fidentity)}">Org Info</a>

Info for existing org.

```
GET /org/{org_id}
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//org/$ORG_ID
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-PUT-org-/org/{(%23%2Fdefinitions%2Forg%2Fdefinitions%2Fidentity)}/add_member">Org Add member</a>

It adds the user as a member of the organization

```
PUT /org/{org_id}/add_member
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *email* | the email of the user | `"username@example.com"` |
| **id** | *integer* | unique identifier of the org | `42` |


#### Curl Example

```bash
$ curl -n -X PUT https://production-room-api.herokuapp.com//org/$ORG_ID/add_member \
  -d '{
  "id": 42,
  "email": "username@example.com"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-room">Room</a>

Stability: `prototype`

An room is virtual place to communicate in an org.

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **avatar_image** | *string* | an avatar image of the room | `"example"` |
| **background_image** | *nullable string* | a background image of the room | `null` |
| **id** | *integer* | unique identifier of the room | `42` |
| **online_members** | *nullable array* | the list of users that are online in the specific room | `null` |
| **org_id** | *integer* | the id of the org that the rooms belongs to | `42` |
| **subtitle** | *nullable string* | the subtitle of the room | `null` |
| **title** | *string* | the title of the room | `"example"` |
| **token** | *nullable string* | a token of the room used for audio and video calls | `null` |

### <a name="link-POST-room-/room">Room Create</a>

Create a new room

```
POST /room
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **avatar_image** | *string* | an avatar image of the room | `"example"` |
| **background_image** | *nullable string* | a background image of the room | `null` |
| **id** | *integer* | unique identifier of the room | `42` |
| **org_id** | *integer* | the id of the org that the rooms belongs to | `42` |
| **subtitle** | *nullable string* | the subtitle of the room | `null` |
| **title** | *string* | the title of the room | `"example"` |


#### Curl Example

```bash
$ curl -n -X POST https://production-room-api.herokuapp.com//room \
  -d '{
  "id": 42,
  "org_id": 42,
  "title": "example",
  "subtitle": null,
  "background_image": null,
  "avatar_image": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```

### <a name="link-PUT-room-/room_access">Room Room access</a>

It updates the current room that the user is in

```
PUT /room_access
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of the room | `42` |


#### Curl Example

```bash
$ curl -n -X PUT https://production-room-api.herokuapp.com//room_access \
  -d '{
  "id": 42
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-social_media">Social Media</a>

Stability: `prototype`

A Login with Social Media

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **[email](#resource-user)** | *email* | the email of the user | `"username@example.com"` |
| **[first_name](#resource-user)** | *string* | first name of the user | `"example"` |
| **[id](#resource-user)** | *integer* | unique identifier of the user | `42` |
| **[image](#resource-user)** | *nullable string* | the image of the user | `null` |
| **[last_name](#resource-user)** | *string* | last name of the user | `"example"` |
| **[mood](#resource-user)** | *nullable object* | the current user mood | `null` |

### <a name="link-POST-social_media-/auth/social_media/{(%23%2Fdefinitions%2Fsocial_media%2Fdefinitions%2Fprovider)}">Social Media Create</a>

create a new Login with social media

```
POST /auth/social_media/{social_media_provider}
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **access_token** | *nullable string* | google generated access_token | `null` |
| **email** | *nullable email* | the email of the user | `null` |
| **family_name** | *nullable string* | last name of the user | `null` |
| **given_name** | *nullable string* | first name of the user | `null` |
| **input_token** | *nullable string* | facebook input token | `null` |
| **name** | *nullable string* | name that comes from facebook | `null` |
| **token_id** | *nullable string* | token id built for an order | `null` |


#### Curl Example

```bash
$ curl -n -X POST https://production-room-api.herokuapp.com//auth/social_media/$SOCIAL_MEDIA_PROVIDER \
  -d '{
  "email": "username@example.com",
  "given_name": "example",
  "family_name": "example",
  "token_id": "example",
  "input_token": "example",
  "name": "example",
  "access_token": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```


## <a name="resource-user">User</a>

Stability: `prototype`

A user

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *email* | the email of the user | `"username@example.com"` |
| **first_name** | *string* | first name of the user | `"example"` |
| **id** | *integer* | unique identifier of the user | `42` |
| **image** | *nullable string* | the image of the user | `null` |
| **last_name** | *string* | last name of the user | `"example"` |
| **mood** | *nullable object* | the current user mood | `null` |

### <a name="link-GET-user-/user">User List</a>

List all users

```
GET /user
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//user
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-GET-user-/user/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Info</a>

Is shows the info for existing user.

```
GET /user/{user_id}
```


#### Curl Example

```bash
$ curl -n https://production-room-api.herokuapp.com//user/$USER_ID
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-PUT-user-/user/{(%23%2Fdefinitions%2Fuser%2Fdefinitions%2Fidentity)}">User Update</a>

Update the user info

```
PUT /user/{user_id}
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *email* | the email of the user | `"username@example.com"` |
| **first_name** | *string* | first name of the user | `"example"` |
| **image** | *nullable string* | the image of the user | `null` |
| **last_name** | *string* | last name of the user | `"example"` |
| **mood** | *nullable string* | the mood of the user | `null` |


#### Curl Example

```bash
$ curl -n -X PUT https://production-room-api.herokuapp.com//user/$USER_ID \
  -d '{
  "first_name": "example",
  "last_name": "example",
  "email": "username@example.com",
  "image": null,
  "mood": null
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


