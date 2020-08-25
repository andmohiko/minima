<template>
  <div>
    <template v-if="user">
      <Top />
    </template>
    <template v-else>
      <NewUser />
    </template>
  </div>
</template>


<script>
import Vue from 'vue'
import Top from '@/components/Top.vue'
import NewUser from '@/components/NewUser.vue'

export default Vue.extend({
  components: {
    Top,
    NewUser
  },
  computed: {
    user() {
      return this.$store.state.currentUser
    }
  }
})
</script>
