<template>
  <div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
    </div>
    <v-btn @click="toManageItems">持ち物管理</v-btn>
    <v-btn @click="logOut">ログアウト</v-btn>
    <div class="genre">
      <EditGenre />
    </div>
  </div>
</template>

<script>
import firebase from "@/plugins/firebase";
import EditGenre from "@/components/EditGenre.vue";

export default {
  components: {
    EditGenre
  },
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
.genre {
  margin: 30px 0;
}
</style>