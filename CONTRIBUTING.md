# Introduction

### 

First of all, thank you for your interest to contribute to the Cryptoexchange project.

There are many ways to contribute! Our documentation surely has room for improvement, bug hunting, bug fixing, writing better walkthrough tutorials for our users, and even feature implementations (new exchange, new APIs).

# Ground Rules
* Write specs (even though our integration test is currently brittle, passing specs for your implementation is highly recommended)
* Verify that the data attribute assignment from the API response is correct (ie. base, target, volume is selected correctly)
* Be welcoming to newcomers and encourage diverse new contributors from all backgrounds.
* Keep changes as small as possible, one branch one feature
* Create issues for any major changes and enhancements that you wish to make. Discuss things transparently and get community feedback.

# Getting started
1. Create a fork of this repository on Github
2. You may create a new branch within your fork (name the branch according to the implementation)
3. If you like the change and think the project could use it:
    * Be sure you have followed the code style for the project.
    * Send a pull request indicating that you have a CLA on file.

# Some things to take note
1. When implementing Ticker, make sure the `base`, `target`, and `volume` are assigned correctly.
2. For example if a pair is BTC/USD, BTC is the `base` and USD is the `target`
3. Another example, if a pair is DOGE/ETH, DOGE is the `base` and ETH is the `target`
4. Some exchanges may not follow convention and get this mixed up
5. `volume` is denominated in the target currency
6. For example if a pair is BTC/USD, the `volume` should be volume in USD and not BTC
7. We started using [https://github.com/vcr/vcr](VCR) to mock out the response in our specs, because our integration test have always been failing
8. If you are implementing a new exchange API in your branch, chances are there is no VCR casette for the API response yet
9. In this case calling `rspec spec/exchanges/<someexchange>` will hit the API for the first time and save the response in the `fixtures` directory
10. Commit the VCR cassette, but do not override or include overrides of existing VCR casettes in your pull request unless there is a good reason to do so

# How to suggest a feature or enhancement
If you have any suggestion on how we can make this gem better, feel free to open an issue for discussion.

# Community
You can chat with the core team member or other participating in this repository chat on [https://gitter.im/cryptoexchange-api/Lobby/~chat#](https://gitter.im/cryptoexchange-api/Lobby/~chat#)