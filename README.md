# naked_wines_flutter_technical_test

Hello! Here is the Naked Wines Flutter Technical Test.

It shows a list of products, a list of items in your basket and tapping on a product list item takes you to the product detail page.

When viewing the list of products or your basket, the product description, stock information and reviews aren't available.

Your task is to:
- Populate the `ProductDetailsPage` as indicated by the `Text` widgets on the page
- Make the add to basket button function when the product is in stock

Things you don't need to worry about:
- Making it look pretty

Things to note:
- This uses the bloc pattern, you can find information about it here: https://bloclibrary.dev/
- Using a `const` constructor isn't a hint
- A widget being `Stateful` or `Stateless` isn't a hint
- The `ProductsService` returns a hardcoded list of `Product` entities, randomises the number of reviews coming back and only 2 products are out of stock
- Very few packages have been used to keep this project as vanilla as possible, this isn't a hint
- The `BasketBloc` keeps track of products in-memory and doesn't do any grouping
