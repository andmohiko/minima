<template>
  <div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
    </div>
    <v-btn @click="toManageItems">持ち物管理</v-btn>
    <v-btn @click="logOut">ログアウト</v-btn>
    <div class="category">
      <EditCategory />
    </div>
  </div>
</template>

<script>
import firebase from "@/plugins/firebase"
import EditCategory from "@/components/EditCategory.vue"

export default {
  components: {
    EditCategory
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
.category {
  margin: 30px 0;
}
</style>