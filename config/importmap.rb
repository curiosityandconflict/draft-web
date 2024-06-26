# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js', preload: true
pin '@rails/actioncable', to: 'https://ga.jspm.io/npm:@rails/actioncable@7.0.7-2/app/assets/javascripts/actioncable.esm.js', preload: true
pin '@rails/activestorage', to: 'https://ga.jspm.io/npm:@rails/activestorage@7.0.8/app/assets/javascripts/activestorage.esm.js', preload: true
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js', preload: true
pin 'sortablejs', to: 'https://ga.jspm.io/npm:sortablejs@1.15.0/modular/sortable.esm.js', preload: true
pin 'toastr', to: 'https://ga.jspm.io/npm:toastr@2.1.4/toastr.js', preload: true
pin '@hotwired/turbo', to: 'https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js', preload: true
pin '@rails/actioncable/src', to: 'https://ga.jspm.io/npm:@rails/actioncable@7.0.7-2/src/index.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
