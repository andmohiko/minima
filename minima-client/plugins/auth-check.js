import firebase from "@/plugins/firebase"
import axios from "@/plugins/axios"

const authCheck = ({ store, redirect }) => {
  firebase.auth().onAuthStateChanged(async user => {
    if (user) {
      const { data } = await axios.get(`/users?uid=${user.uid}`)
      store.commit("setUser", data.value.user)
      store.commit("setItems", data.value.items)
    } else {
      store.commit("setUser", null)
      store.commit("setItems", null)
    }
  });
}

export default authCheck
