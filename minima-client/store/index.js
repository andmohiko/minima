import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = () => {
  return new Vuex.Store({
    state: {
      currentUser: null,
      items: [],
      genres: []
    },
    mutations: {
      setUser(state, payload) {
        state.currentUser = payload
      },
      setItems(state, payload) {
        state.items = payload
      },
      setGenres(state, payload) {
        state.genres = payload
      },
    },
    actions: {
    }
  })
}

export default store
