# user/new.ecr

Copy & Paste the code block below into: `views/user/new.ecr`

```crystal
<h1>Sign Up</h1>

<%- if user %>
  <%- if user.errors %>
    <ul class="errors">
    <%- user.errors.each do |error| %>
      <li><%= error.to_s %></li>
    <%- end %>
    </ul>
  <%- end %>
<%- end %>

<form action="/registration" method="post">
  <%= csrf_tag %>
  <div class="form-group">
    <input class="form-control" type="email" name="email" placeholder="Email"/>
  </div>
  <div class="form-group">
    <input class="form-control" type="password" name="password" placeholder="Password"/>
  </div>
  <button class="btn btn-success btn-sm" type="submit">Register</button>
</form>
<hr/>
<%= link_to("Already have an account?", "/signin") -%>
```