# BookFinder
I undertook this project with the intention of mastering Combine and concurrency. Through building this application, I aimed to gain a deeper understanding of how to integrate asynchronous operations and utilize Combine's powerful features. By implementing features like searching for books and fetching data from an external API, I strived to apply these concepts in a practical context. This project served as a valuable learning experience, allowing me to explore and experiment with SwiftUI's reactive programming paradigm and asynchronous data handling. Overall, it provided an opportunity to enhance my skills in modern iOS development, specifically in handling asynchronous tasks and data flow management using Combine.



This code is a SwiftUI application that allows users to search for books using the Open Library API and display the results in a list. Let's break down the code into its components:

**BookSearch**: This file contains the BookSearch view. It sets up the navigation structure and incorporates the BookPlaceholder view when the search text is empty, and the BookList view when there is search text.
**BookList**: This file contains the BookList view, responsible for displaying the list of books fetched from the API. It utilizes List to display the books, and each book is displayed along with its cover image (downloaded asynchronously) and a "Set as favourite" button. The downloadImage(from:) function downloads the cover images using asynchronous networking.
**BookListViewModel**: This file contains the BookListViewModel class, which acts as the ViewModel for the BookList view. It manages the data flow, including searching for books based on the provided search text. It uses Combine publishers to handle the search text changes and fetches the book data asynchronously using URLSession.
**downloadImage**: This function is defined outside of any structure. It takes a URL as input, asynchronously downloads the image data using URLSession, and returns a UIImage.
**Model**: The model for the book data is not provided in the code snippet but it's referenced in BookListViewModel where decoding of JSON data into model objects happens.

In summary, this SwiftUI application allows users to search for books, fetches the book data from the Open Library API, and asynchronously downloads and displays the book cover images along with the book details in a list view.




