# BookFinder
I undertook this project with the intention of mastering Combine and concurrency. Through building this application, I aimed to gain a deeper understanding of how to integrate asynchronous operations and utilize Combine's powerful features. By implementing features like searching for books and fetching data from an external API, I strived to apply these concepts in a practical context. This project served as a valuable learning experience, allowing me to explore and experiment with SwiftUI's reactive programming paradigm and asynchronous data handling. Overall, it provided an opportunity to enhance my skills in modern iOS development, specifically in handling asynchronous tasks and data flow management using Combine.<br>

This code is a SwiftUI application that allows users to search for books using the Open Library API and display the results in a list. Let's break down the code into its components:<br>
**Placeholder**: This file contains the Placeholder of a Trandings search book, it will search for a specific book selected form a list of three of them displayed.<br>

**BookList**: This file contains the BookList view, responsible for displaying the list of books fetched from the API. It utilizes List to display the books, and each book is displayed along with its cover image (downloaded asynchronously) and a "Set as favourite" button(Still in progress).<br>

**BookListViewModel**: This file contains the BookListViewModel class, which acts as the ViewModel for the BookList view. It manages the data flow, including searching for books based on the provided search text. It uses Combine publishers to handle the search text changes and fetches the book data asynchronously using URLSession.<br>

**downloadImage**: This function takes a URL as input, asynchronously downloads the image data using URLSession, and returns a UIImage.<br>

**Model**: The model for the book data is referenced in BookListViewModel where it's used to decoding JSON data into model objects.<br>

<img src="https://github.com/Ffalco0/bookLibrary/assets/142512909/71f4fb29-f45c-43d2-96f0-01cdd0bd96ec" alt="IMG_0944" width="300" />
<img src="https://github.com/Ffalco0/bookLibrary/assets/142512909/2c848153-fd50-4797-b52d-02cb16bc7f2b" alt="IMG_0944" width="300" />
<img src="https://github.com/Ffalco0/bookLibrary/assets/142512909/c188d440-5a22-464b-a987-cd78ac60e2a7" alt="IMG_0944" width="300" /><br><br><br>

In summary, this SwiftUI application allows users to search for books, fetches the book data from the Open Library API, and asynchronously downloads and displays the book cover images along with the book details in a list view.



