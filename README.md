# Toy Robot Simulator

### About the application.

This application has been developed and tested in ruby 2.4.0.

### Installation

Clone the repo or get the zip.

cd toy_robot

gem install bundler

bundle install

### Running the application

There are two ways to run the application.

1. ruby toy_robot.rb will wait for input from the keyboard. After specifying commands, press *ctrl-d* (assuming linux)

2. ruby toy_robot.rb < commands-a.txt will read commands from the supplied text file. There are three sample commands files (**commands-a.txt, commands-b.txt, commands-c.txt**) available.

### Running the test

Tests can be run with "rspec spec"
