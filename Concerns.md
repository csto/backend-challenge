# Concerns

Friendship model should have a unique index that goes in both directions to ensure multiple friendships with the same two members cannot be made.
The custom counter cache on the Friendship model needs to account for potentially changing member_a or member_b.
ShortLinkService should be moved to a background job depending on requirements.
ShortLinkService needs to handle hitting the Bitly max API request limit and Bitly being down, both would be solved by running as a background job.
HeadingService would be better suited as a background job.
HeadingService needs to handle not being able to open the provided URL. Retrying with a background job would mostly solve this.
HeadingService does not work for html generated via JS after the initial load.  A headless browser like webdriver would work much better.
The members table should have an ngram style index on name for better searching.
The headings table should have an ngram style index on value for better searching.
There is an N+1 query in friendships/index.html.erb that needs fixed.
There is an N+1 query in friendships/new.html.erb that needs fixed.
ExpertsController#connections was left unfinished.  The page needs to take the result of the ShortestPathService and show the path of the members.
ShortestPathService should be run in a background job.
ShortestPathService technically only returns the first shortest path it finds.  It might be better to provide all equally short paths.
ShortestPathService uses a modified Breadth-First Search (BFS) taken from https://medium.com/better-programming/5-ways-to-find-the-shortest-path-in-a-graph-88cfefd0030f.  Technically a bidirectional BFS would be half the time, but I ran out of time to implement it.
There were multiple ways you could populate the data for the BFS which have their own pros and cons as follows:
  1. Populate an adjacency matrix with all friendships.
    Pros: Linear run time after populating data.  Could be cached to reduce hit on database.
    Cons: Requesting the data would require require getting all of your friendships out of the database at once and would take an enormous amount of ram.  Every member added would exponentially grow the amount of ram and could easily exhaust your resources.
  2. Request friends of one member at a time.
    Pros: Will not exhaust the database.  Will not exhaust server memory (except there is a chance storing the visited ids could exhaust memory)
    Cons: Slow. It can run up to as many queries as there are members.
  3. Request friends for each tier of connections (your friends, your friends friends, your friends friends friends, etc).
    Pros: Less database requests than above.
    Cons: Could be requesting too much data at once the same as for #1. 10,000 friends with 10,000 friends each would easily exhaust all resources.
I chose #2 because it is significantly less likely to exhaust resources (server or database) on a massive amount of data, plus it would work great as a background job.  This choice would depend on the size of your data and expected growth though.  Limiting the total depth of the search makes this even safer.
I'm missing a few tests around the models.
All controllers need tested.
HeadingService and ShortLinkService need tested.
ShortestPathService needs testing at a larger scale of members.
