---
title:  "Notes on WebSockets (II)"
date:   2018-02-25 00:00:00 +0800
categories: Software
excerpt: "The C++ example is updated using this time Boost Beast as its framework."
header:
  image: "golden_record_cropped.jpg"
---

Just a short update on the previous WebSockets entry. I have reimplemented this time the C++ server code using [Boost's Beast][boost_beast]. It took me a while to find my way around the modern C++ elements in Beast but I believe this implementation is superior on the previous one using [websocketpp][websocketpp]. Beast is the amazing work of [Vinnie Falco][VF] who is part of the body leading the evolution of the C++ language. His _advanced_server_flex_ comes with the unique capability to handle simultaneously web sockets and HTTP connection, both either plain or SSL-backed.

My work just consisted on the some refactoring to isolate the "handling" of messages received so in the future I can reuse most of the code. I built two examples. One is the HTTP file server with the code coming from the original `advanced_server_flex.cpp` (I believe it is cleaner and neater this way). The other comes with the ability to broadcast messages to all the connected clients, which is a feature I plan to use in some projects.

The code is [here][code]. Again, my prime environment at home these days is Windows so the examples come inside Visual Studio projects. Anybody using a different environment would need to find its way around.

One final word on my feelings about the latest C++ features. I started coding C++ in 1992 and I've done so for many years since on a daily basis. Many on my projects have a focus on its ability to run on multiple platforms: Windows, Linux, Android, etc. In this context, I have become very conservative and reluctant to use the latest compiler or language features, I have to compromise and find a solid common denominator that can work across multiple platforms and compilers. On the other hand Beast makes full use of the latest bells and whistles in the language. This is not a bad thing. Without making full use of these new features it wouldn't be possible to write clean and compact code that is so flexible to handle all sort of connections: web sockets and HTTP both in plain and SSL flavors. So, given this reward, I had to invest quite a bit of time trying to find my way around Vinnie's code and all these modern C++ features. To give one example, the [move constructor and move semantics][move_semantics]:

> ... A move constructor of class T is a non-template constructor whose first parameter is T&&, const T&&, volatile T&&, or const volatile T&&, and either there are no other parameters, or the rest of the parameters all have default values...

>...The move constructor is typically called when an object is initialized (by direct-initialization or copy-initialization) from rvalue (xvalue or prvalue) (until C++17)xvalue (since C++17) of the same type...

... OK... thank you for the explanation, I guess. It turns out that this is meant to avoid creating temporally instances when passing them by value to some function. We can save some valuable execution time depending on how complex is the object and how many times we call the function. But, do we really need this? I'm aware that passing an object by value would create a copy of it. This is why in my code I rarely do. I pass a pointer, problem solved. And I will continue to pass pointers even though I know of this feature. I don't want to scare less seasoned developers away from my code.

C++ can be a beautiful language, we don't need to make it even more complicated than it already is.

[VF]:             https://github.com/vinniefalco
[repository]:     https://github.com/EdFuentetaja/WebSockets
[websocketpp]:    https://github.com/zaphoyd/websocketpp
[boost_beast]:    https://www.boost.org/doc/libs/1_66_0/libs/beast/doc/html/index.html
[code]:           https://github.com/EdFuentetaja/WebSockets/tree/master/WebSocketCPP_Beast
[move_semantics]: https://en.cppreference.com/w/cpp/language/move_constructor
