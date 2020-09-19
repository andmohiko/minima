import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({ store, redirect }) => {
  firebase.auth().onAuthStateChanged(async user => {
    if (user) {
      try {
        const data_user = await axios.get(`/users?uid=${user.uid}`)
        store.commit("setUser", data_user.data.value)
        const data_items = await axios.get(`/items?uid=${user.uid}`)
        store.commit("setItems", data_items.data.value)
        const data_categories = await axios.get(`/categories?uid=${user.uid}`)
        store.commit("setCategories", data_categories.data.value)
      } catch (e) {
        console.log('error in auth check')
        console.error(e)
      }
    } else {
      store.commit("setUser", null)
      store.commit("setItems", null)
      store.commit("setCategories", null)
    }
  });
}

export default authCheck
