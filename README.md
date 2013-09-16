# Profess

A toolkit for building beautiful HTML5 presentations using Reveal.js and Markdown (kramdown, actually).
Features include:

  * Write your slide content in [kramdown](http://kramdown.rubyforge.org/), a powerful superset of [Markdown](http://daringfireball.net/projects/markdown/)
  * Insert ERB blocks into your slides
  * Include other Markdown files within your Markdown (e.g. title slides and other slides common to multiple presentations)
  * Include external source code files within your Markdown

## Doesn't Reveal.js already support Markdown?

Yes, it does.  However 


## Example

    <%= render markdown: 'title_slides.md' %>
    
    Slide 1
    ==============
    
      * Bullet 1
      * Bullet 2
    
    ::
    
    Slide 2
    =======
    
    Oh, look, a code sample:
    
    ````ruby
      def hello
        puts "Hello world"
      end
    ````
    
    :: 
    
    Slide 3
    =======
    
    We can even include external code files:
    
    <%= render code: 'test.rb', lang: :ruby %>

## Workflow

### Prerequisites

You will need Ruby installed.  We recommend using [rvm](http://rvm.io/).

````bash
\curl -L https://get.rvm.io | bash -s stable
source "$HOME/.rvm/scripts/rvm"
rvm install 2.0.0
rvm use 2.0.0 --default
````

### Installation

````bash
gem install profess
````

### Generating a new project

You would typically create a new project for each course you're teaching, for example, if you're a professor.  A project can contain multiple slide decks.

````bash
profess new PROJECTNAME --project
````

where `PROJECTNAME` is the name of your project (e.g. course name, conference name).

### Generating a new slide deck

````bash
profess new DECKNAME
````

where `DECKNAME` is the name of the slide deck you're creating.

### Viewing your slides

````bash
profess serve
````

All decks in your project will now be accessible from http://localhost:8000.
