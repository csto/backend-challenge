# TODO

## Pages

New member - GET /members/new
  name
  website_url

Create member - POST /members
  create short link
  create headings

List members - GET /members
  name, short url, friendship count

Show member - /members/:id
  search experts (input that goes to List experts)
  name, website url, short url
  headings list (paginate)
  friends list and link to friends (paginate)

Add friends - GET /members/:member_id/friendships/new
  search input to list members by name (maybe headings)
  button to add friend to member

Create friendship - POST /friendships
  pass in member_a and member_b

List friendships - GET /members/:member_id/friendships

List experts - GET /members/:member_id/experts/:search
  list members (experts) who are not friends of member and who have headings related to the topic
  show path from member to expert
  search can have multiple words


## Database

members
  name
  website_url
  website_short_url
  friendships_count
  * email
  * password_digest

headings
  member_id
  value

friendships
  member_a
  member_b


## Things to consider

Bitly has API limits that need to be handled.
If Bitly is down, a new member cannot be created.  Creating short links should be a background job.
HeadingService errors need to be handled.
HeadingService#process should be a background job.
HeadingService#process should limit the number of headings it creates.
Handle empty state for members, headings and friends lists
