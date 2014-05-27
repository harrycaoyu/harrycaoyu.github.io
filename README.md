# Flybrizi.com

This is the source code to the site hosted at [flybrizi.com][http://flybrizi.com]. It is a Jekyll site, using Bootstrap for front-end code and GNU Make for deployment.

# Installation and setup

Jekyll needs to be installed to generate the site. Install Jekyll as described [here][http://jekyllrb.com/docs/installation/].

In addition, the site uses the LESS CSS preprocessor, which can be installed as described [here][http://lesscss.org/#using-less]. If `npm` is unavailable, it can also be installed with `apt-get`:

    sudo apt-get install node-less

If `pip` is available, with:

    sudo pip install lesscss

And if `pip` is not around but Python is available, `pip` can be installed as described [here][http://pip.readthedocs.org/en/latest/installing.html].

GNU Make can be installed in too many different ways, but is usually present on most Unix-like systems. On Windows, MinGW or Cygwin come with Make.

Then to build the CSS and the site, run:

    make build

The CSS will be generated in the `css` directory, and the entire site will be built in the `_site` directory.

# Deployment

The Makefile can upload the generated site using `scp` to the configured server, as specified by the following Makefile variables:

- USER
- SERVER
- REMOTE_SITE

and then running:

    make sync

# Development

The Makefile has some convenient targets for testing. The website can be built and served locally (`localhost:4000`) with:

    make serve

However note that although the Jekyll development server watches for changes in the files and rebuilds the site, it does not re-run `lessc` to rebuild the CSS. The CSS needs to be rebuilt manually, with:

    make build

To remove the generated site and all CSS, run:

    make clean

**NOTE**: this command removes *all* CSS files under the CSS directory.

# References

Jekyll documentation:    [http://jekyllrb.com/docs/home/]<br>
LESS documentation:      [http://lesscss.org/features/]<br>
Bootstrap documentation: [http://getbootstrap.com/]<br>
Make documentation:      [http://www.gnu.org/software/make/manual/make.html]<br>
