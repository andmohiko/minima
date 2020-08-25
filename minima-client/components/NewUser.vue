<template>
  <div>
    <v-btn @click="login">ログイン</v-btn>
    <v-btn @click="signup">新規登録</v-btn>
  </div>
</template>


<script>
import Vue from 'vue'

export default Vue.extend({
  methods: {
    login() {
      this.$router.push("/login");
    },
    signup() {
      this.$router.push("/signup");
    }
  }
})
</script>
