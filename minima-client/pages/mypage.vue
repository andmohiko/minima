<template>
  <div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
    </div>
    <v-btn @click="logOut">ログアウト</v-btn>
  </div>
</template>

<script>
import firebase from "@/plugins/firebase";

export default {
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    logOut() {
      firebase
        .auth()
        .signOut()
        .then(() => {
          this.$store.commit("setUser", null);
          this.$router.push("/login");
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style>
</style>