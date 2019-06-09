class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case 
  
  before_validation :make_title_case 
  
  
  <h2>Editing "<%= @post.title %>"</h2>
<%= form_tag post_path(@post), method: "patch" do %>
  <% if @post.errors.any? %>
    <div id="error_explanation">
      <h2>There were some errors:</h2>
      <ul>
        <% @post.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end  %>

  <div class="field <%= ' field_with_errors' if @post.errors[:title].any? %>">
    <%= label_tag "title", "Title" %>
    <%= text_field_tag "title", @post.title %>
  </div>

  <div class="field <%= ' field_with_errors' if @post.errors[:category].any? %>">
    <%= label_tag "category", "Category" %>
    <p>Must be either "Fiction" or "Non-Fiction".</p>
    <%= text_field_tag "category", @post.category %>
    <p>
      Please type carefully as our top scientists are working around the clock to
      enable state-of-the-art dropdown technology for this form field.
    </p>
  </div>

  <div class="field <%= ' field_with_errors' if @post.errors[:content].any? %>">
    <%= label_tag "content", "Content" %>
    <br />
    <%= text_area_tag "content", @post.content %>
  </div>
  
  <%= submit_tag "Update" %>
<% end %>
  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
