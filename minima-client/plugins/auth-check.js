import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({ store, redirect }) => {
  firebase.auth().onAuthStateChanged(async user => {
    if (user) {
      try {
        const { data } = await axios.get(`/users?uid=${user.uid}`)
        store.commit("setUser", data.value.user)
        store.commit("setItems", data.value.items)
        store.commit("setCategories", data.value.categories)
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
