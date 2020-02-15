# user/show.ecr

Copy & Paste the code block below into: `views/user/show.ecr`

```crystal
<h1>Profile</h1>
<p>
  <%= user.email %>
  <%= link_to("Edit", "/profile/edit", class: "btn btn-success btn-sm") %>
</p>
```