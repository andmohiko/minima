<template>
  <div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
      {{ user }}

      <p>items</p>
      {{ myItems }}
    </div>
    <v-btn @click="toManageItems">持ち物管理</v-btn>
    <v-btn @click="logOut">ログアウト</v-btn>
  </div>
</template>

<script>
import firebase from "@/plugins/firebase";

export default {
  computed: {
    user() {
      return this.$store.state.currentUser
    },
    myItems() {
      return this.$store.state.items
    }
  },
  methods: {
    toManageItems() {
      this.$router.push("/");
    },
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