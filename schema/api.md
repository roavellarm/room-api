
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


## <a name="resource-social_media">Social Media</a>

Stability: `prototype`

A Login with Social Media

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **[email](#resource-user)** | *email* | the email of the user | `"username@example.com"` |
| **[first_name](#resource-user)** | *string* | first name of the user | `"example"` |
| **[id](#resource-user)** | *integer* | unique identifier of the user | `42` |
| **[last_name](#resource-user)** | *string* | last name of the user | `"example"` |

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
| **last_name** | *string* | last name of the user | `"example"` |

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


