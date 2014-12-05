# Iron Shop

## Angular Examples

  Angular app definition and controllers can be found at app/assets/javascript. We are using angular to communicate   with a JSON backend to pull data from the backend as well as full text searching. The views using this are found in app/views/static_pages/home

This will be another week-long project, similar to last week's. This time, we will be building a simple storefront. Planned class topics for the week:

* More on model specs
* Stripe
* Background workers
* Closer look at SQL (w/ some Postgres specific features like full text search, JSON fields, views)

Client-side JS enhancements to this project are are welcome, but I expect most of the logic to be handled (and fully tested!) server side.

# Features

Here's your initial backlog. Your team should prioritize these -

* Sending emails (including Devise emails) in the background (C)
* Have at least 3 different user roles (e.g. shopper, seller, admin) with different features available to them
* (Some) users can post items for sale
* Users can search for items by title or description (pg_search is fine, elasticsearch would be cool if you're ambitious)
* Sellers can distribute coupon codes that buyers apply at checkout
* Take payments via e.g. Stripe (C)
* Let users set a "price watch" that emails them within e.g. 10 minutes of an item's price changing (C)
* Project tests running on Travis (or comparable service), with 100% test coverage (and badges to prove it)

(C) - should be at least partially covered in class
