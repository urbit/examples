window.urb.appl = "wiki"

debugEnabled = true

if (debugEnabled) var debug = console.log.bind(window.console)
else var debug = function(){}

function bindPath(path, callback) {
  window.urb.bind("/wiki/" + path, callback)
}

function dropPath(path, callback) {
  window.urb.drop("/wiki/"  + path, callback)
}

function articleContentPath(article) {
  // escape illegal chars in the article name and add a unique suffix
  // to prevent issues with duplicate subscriptions
  return "article/content/" + escapePathElement(article) + "/" + Date.now()
}

function articleHistoryPath(article) {
  // escape illegal chars in the article name and add a unique suffix
  // to prevent issues with duplicate subscriptions
  return "article/history/" + escapePathElement(article) + "/" + Date.now()
}

/**
 * escape illegal chars for subscription paths (wimilar to ++wood)
 */
function escapePathElement(s) {
  var e = ""
  var i = 0
  for (i = 0; i< s.length; ++i) {
    var c = s.charAt(i)
    if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || (c == '-')) {
      e += c

    } else if (c == ' ') {
      e += '.'

    } else if (c == '.') {
      e += '~.'

    } else if (c == '~') {
      e += '~~'

    } else {
      e += "~" + s.charCodeAt(i).toString(16) + "."
    }
  }

  return e
}

function poke(article, callback) {
  window.urb.send(
    article,
    {mark: "wiki-change"},
    (err,res) => {
      if (err) {
        debug(err)
        //this.error = "There was an error. Sorry!"

      } else if(res.data !== undefined &&
         res.data.ok !== undefined &&
         res.data.ok !== true) {

        debug(res.data.res)
        //this.error = res.data.res

      } else {
        if (callback) {
          callback()
        }
      }
    })
}

function render(content) {
  // replace internal links
  var linkPattern = /\[\[([^\]]*)\]\]/
  var parts = content.split(linkPattern)
  content = ""
  for (i in parts) {
    if (i % 2 == 1) {
      var escaped = encodeURIComponent(parts[i])
      content += "[" + parts[i] + "](/pages/wiki#/view/" + escaped + ")"

    } else {
      content += parts[i]
    }
  }

  return marked(content)
}

/**
 * Mixin for components that need to subscribe to an urbit path
 *
 * The component must define a property (or a computed property) called
 * 'urbitBindPath', and a callback method called 'urbitAccept'
 *
 * This path will be bound when the component is created and dropped when the
 * component is destroyed.
 * It will also be dropped and rebound when the route changes.
 */
var urbitSubscriptionMixin = {
  data: function() {
    return {
      urbitBoundPath: null,
    }
  },
  created: function() {
    this.urbitBind()
  },
  destroyed: function() {
    this.urbitDrop()
  },
  watch: {
    '$route' (to, from) {
      this.urbitDrop()
      this.urbitBind()
    }
  },
  methods: {
    urbitBind: function() {
      if (this.urbitBindPath) {
        this.urbitBoundPath = this.urbitBindPath
        bindPath(this.urbitBoundPath, this.urbitAccept)
      }
    },
    urbitDrop: function() {
      if (this.urbitBoundPath) {
        dropPath(this.urbitBoundPath, this.urbitAccept)
      }
    }
  }
}


const AllArticles = {
  template: `
    <div>
      <b-card class="mb-2" :show-header="true">
        <h1 slot="header">Articles</h1>
        <ul v-for="article in articles">
          <li><router-link :to="{ name: 'view', params: { article: article } }">{{ article }}</router-link></li>
        </ul>
        <div v-if="loading">Loading...</div>
        <div v-else-if="articles.length == 0">
          No articles found
        </div>
      </b-card>
    </div>
  `,
  computed: {
    loading: function() {
      return this.$root.articlesLoading
    },
    articles: function() {
      return this.$root.articles
    }
  }
}


const Edit = {
  mixins: [ urbitSubscriptionMixin ],
  props: [ "article" ],
  template: `
    <div>
      <b-card class="mb-2" :show-header="true">
        <h1 slot="header">Edit {{ article }}</h1>
        <div>
          <small>as ~{{ $root.user }}</small>
        </div>
        <b-form-input :textarea="true" :cols="80" :rows="25" v-model="content" :disabled="loading || saving"
            placeholder="Enter wiki content here..." />

        <b-form-fieldset label="Change description">
          <b-form-input v-model.trim="message" placeholder="Describe your change" />
        </b-form-fieldset>

        <b-button-group>
          <button @click="preview" role="button" class="btn btn-secondary">Preview</button>
          <button @click="save" role="button" class="btn btn-primary" :disabled="saveDisabled">Save</button>
          <button @click="back(false)" role="button" class="btn btn-secondary">Cancel</button>
        </b-button-group>

        <div v-if="changedOnServer">
          Warning: a newer version has been saved, you'll need to reload before
          saving your changes
        </div>

        <div>{{ error }}</div>

        <b-card v-if="previewContent" :show-header="true">
          <h2 slot="header">Preview</h2>
          <div class="rendered" v-html="previewContent" />
        </b-card>
      </b-card>

      <!-- discard changes confirmation dialog -->
      <b-modal ref="discardChangesModal" title="Unsaved Changes"
          ok-title="Discard Changes" close-title="Cancel"
          @ok="discardChanges">

        You have unsaved changes. Are you sure you want to navigate away?
      </b-modal>
    </div>
  `,
  data: function() {
    return {
      loading: true,
      saving: false,
      content: "loading...",
      loadedContent: null,
      version: null,
      error: null,
      previewContent: null,
      changedOnServer: false,
      message: ""
    }
  },
  computed: {
    urbitBindPath: function() {
      this.loading = true
      return articleContentPath(this.article)
    },
    saveDisabled: function() {
      if (this.loading || this.changedOnServer || this.saving) {
        return true
      }

      if (this.message.length == 0) {
        return true
      }

      return false
    },
    changed: function() {
      if (this.loading) {
        return false
      }

      if (this.saving) {
        return false
      }

      if (this.content != this.loadedContent || this.message != "") {
        return true
      }

      return false
    }
  },
  created: function() {
    window.onbeforeunload = () => {
      if (this.changed) {
        return "You have unsaved changes. Are you sure you want to navigate away?";
      }

      return null
    }
  },
  destroyed: function() {
    window.onbeforeunload = null
  },
  beforeRouteLeave: function(to, from, next) {
    if (this.confirmDiscardChanges()) {
      next(false)

    } else {
      next()
    }
  },
  methods: {
    urbitAccept: function(err, dat) {
      if (dat.data.article != this.article) {
        return
      }
      if (!this.loading) {
        if (dat.data.version != this.version) {
          this.changedOnServer = true
        }
        return
      }
      this.content = dat.data.content
      this.loadedContent = this.content
      this.version = dat.data.version
      this.loading = false
      this.changedOnServer = false
    },
    preview: function() {
      this.previewContent = render(this.content)
    },
    save: function() {
      this.saving = true
      poke({
        "article": this.article,
        "content": this.content,
        "version": this.version,
        "message": this.message,
      }, () => {
        this.back(true)
      })
    },
    back: function(saved) {
      if (this.version == "0" && !saved) {
        this.$router.push({ path: "/"} )

      } else {
        this.$router.push({ name: "view", params: { article: this.article } })
      }
    },
    confirmDiscardChanges: function() {
      if (this.changed) {
        this.$refs.discardChangesModal.show()
        return true

      } else {
        return false
      }
    },
    discardChanges: function() {
      this.saving = true
      this.back(false)
    }
  }
}


const View = {
  mixins: [ urbitSubscriptionMixin ],
  props: [ "article" ],
  template: `
    <div>
      <b-card class="mb-2" :show-header="true">
        <div slot="header">
          <h1>{{ article }}</h1>
          <small v-if="author">
            Last edit by: {{ author }}
            (at: {{ at }})
          </small>
        </div>

        <div v-if="loading">
          Loading...
        </div>
        <div v-else class="rendered" v-html="contentRendered" />
      </b-card>
    </div>
  `,
  data: function() {
    return {
      loading: true,
      content: null,
      author: null,
      at: null,
    }
  },
  computed: {
    urbitBindPath: function() {
      this.loading = true
      this.author = null
      return articleContentPath(this.article)
    },
    contentRendered: function() {
      if (this.content == null) {
        return "Loading..."
      }

      return render(this.content)
    }
  },
  methods: {
    urbitAccept: function(err, dat) {
      if (dat.data.article != this.article) {
        return
      }
      if (dat.data.version == "0") {
        this.edit()
        return
      }
      this.content = dat.data.content
      this.author = dat.data.author
      this.at = new Date(dat.data.at).toString()
      this.loading = false
    },
    edit: function() {
      this.$router.push({ name: "edit", params: { article: this.article } })
    }
  }
}


const History = {
  mixins: [ urbitSubscriptionMixin ],
  props: [ "article" ],
  template: `
    <div>
      <b-card class="mb-2" :show-header="true">
        <h1 slot="header">History of {{ article }}</h1>

        <div v-if="loading">
          Loading...
        </div>

        <div v-else>
          <b-table striped hover :items="revisions" :fields="fields" @row-clicked="rowClicked"
              :show-empty="true" empty-text="No revisions found">
            <template slot="at" scope="data">
             {{ new Date(data.value).toString() }}
           </template>
          </b-table>

          <div v-if="selected">
            <b-form-fieldset label="View as:">
              <b-form-radio v-model="viewAs" :options="options" />
            </b-form-fieldset>

            <b-card class="mb-2" :show-header="true">
              <h2 slot="header">Version {{selected.version}}</h2>

              <div v-if="viewAs == 'preview'">
                <div class="rendered" v-html="contentRendered"  />
              </div>
              <div v-else>
                <b-form-input :textarea="true" v-model="selected.content"
                    :readonly="true" :cols="80" :rows="20" />
              </div>
            </b-card>
          </div>
        </div>
      </b-card>
    </div>
  `,
  data: function() {
    return {
      loading: true,
      revisions: [],
      selected: null,
      selectedIndex: -1,
      viewAs: "preview",
      options: [
        { text: "Source", value: "source" },
        { text: "Preview", value: "preview" },
      ],
      fields: {
        version: {
          label: "Version",
        },
        at: {
          label: "Date",
        },
        author: {
          label: "Author",
        },
        message: {
          label: "Description",
        },

      }
    }
  },
  computed: {
    urbitBindPath: function() {
      this.loading = true
      this.selected = null
      this.selectedIndex = -1
      this.revisions = []
      return articleHistoryPath(this.article)
    },
    contentRendered: function() {
      return render(this.selected.content)
    },
  },
  methods: {
    urbitAccept: function(err, dat) {
      if (dat.data.ok) {
        return
      }

      this.revisions = dat.data
      this.loading = false
    },
    rowClicked: function(item, index) {
      if (this.selectedIndex > -1) {
        this.revisions[this.selectedIndex]._rowVariant = null;
      }
      this.selected = item
      this.selectedIndex = index
      this.revisions[index]._rowVariant = 'info'
    }
  }
}


Vue.component('nav-bar', {
  template: `
    <b-nav>
      <b-nav-item to="/">Home</b-nav-item>
      <b-nav-item :to="{name: 'all'}">All</b-nav-item>
      <div v-if="showEdit">
        <b-nav-item v-if="!editAllowed" :disabled="true"
            title="Duke rank (planet) or higher required to edit">
          Edit <small>?</small>
        </b-nav-item>

        <b-nav-item v-else
          :to="{name: 'edit', params: {article: this.article}}">
        Edit
        </b-nav-item>
      </div>
      <b-nav-item v-if="showHistory" :to="{name: 'history', params: {article: this.article}}">History</b-nav-item>
      <b-nav-item v-if="showLatest" :to="{name: 'view', params: {article: this.article}}">Latest</b-nav-item>
    </b-nav>
  `,
  computed: {
    article: function() {
      return this.$route.params['article']
    },
    showEdit: function() {
      return this.article != null
          && this.$route.name != 'edit'
          && this.$route.name != 'history'
    },
    showHistory: function() {
      return this.article != null
          && this.$route.name != 'history'
    },
    showLatest: function() {
      return this.$route.name == 'history'
    },
    editAllowed: function() {
      return this.$root.dukeOrBetter
    }
  }
})


const DEFAULT_TITLE = document.title

const routes = [
  { name: 'default', path: '/', redirect: '/view/MainPage' },
  { name: 'edit', path: '/edit/:article', component: Edit, props: true,
      meta: { title: "Edit {article}" } },
  { name: 'view', path: '/view/:article', component: View, props: true,
      meta: { title: "{article}" } },
  { name: 'history', path: '/history/:article', component: History, props: true,
      meta: { title: "History of {article}"} },
  { name: 'all', path: '/all', component: AllArticles,
      meta: { title: "All Articles"} },
]


const router = new VueRouter({
  routes // short for `routes: routes`
})

router.beforeEach((to, from, next) => {
  var title = ""
  if (to.meta.title) {
    title = to.meta.title
    for (param in to.params) {
      title = title.replace('{' + param + '}', to.params[param])
    }

    title += " | "
  }
  title += DEFAULT_TITLE
  document.title = title
  next()
})

var app = new Vue({
  router,
  template: `
    <div>
      <nav-bar />

      <router-view />
    </div>
  `,
  data: function() {
    return {
      articles: [],
      articlesLoading: true,
    }
  },
  computed: {
    user: function() {
      return window.urb.user
    },
    dukeOrBetter: function() {
      return window.urb.user.length <= 13
    }
  },
  created: function() {
    bindPath("article/list", this.acceptList)
  },
  destroyed: function() {
    dropPath("article/list", this.acceptList)
  },
  methods: {
    acceptList: function(err, dat) {
      this.articles = Object.keys(dat.data)
      this.articlesLoading = false
    },
  }
}).$mount('#app')
