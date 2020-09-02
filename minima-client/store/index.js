import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = () => {
  return new Vuex.Store({
    state: {
      currentUser: null,
      items: [],
      categories: []
    },
    mutations: {
      setUser(state, payload) {
        state.currentUser = payload
      },
      setItems(state, payload) {
        state.items = payload
      },
      setCategories(state, payload) {
        state.categories = payload
      }
    },
    actions: {
    }
  })
}

export default store
