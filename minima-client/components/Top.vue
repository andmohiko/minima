<template>
  <div class="container">
    <div class="add-item">
      <div>
        <v-text-field
          v-model="name"
          type="text"
          placeholder="name"
        ></v-text-field>
        <v-select
          v-model="level"
          :items="levels"
          placeholder="level"
        ></v-select>
      </div>
      <v-btn @click="addItem">add item</v-btn>
    </div>
    <div class="items-own">
      <v-data-table
        :headers="headers"
        :items="items"
        :items-per-page="20"
        class="elevation-1"
      ></v-data-table>
    </div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import axios from '@/plugins/axios'
export default Vue.extend({
  data() {
    return {
      levels: [5, 4, 3, 2, 1],
      name: '',
      level: 5,
      headers: [
        {
          text: '名前',
          value: 'name'
        },
        {
          text: '重要度',
          value: 'level'
        },
        {
          text: 'userid',
          value: 'user_id'
        }
      ]
    }
  },
  computed: {
    user() {
      return this.$store.state.currentUser
    },
    items() {
      console.log(this.$store.state.items)
      return this.$store.state.items
    }
  },
  methods: {
    addItem() {
      const addingItem = {
        name: this.name,
        level: this.level,
        user_id: this.user.id
      }
      console.log('addingItem', addingItem)
      try {
        if (this.isValid(addingItem)) {
          console.log(addingItem)
          axios.post('/items', addingItem)
          this.items.push(addingItem)
          store.commit("setItems", this.items)
        } else {
          console.log('else error', addingItem)
        }
      } catch {
        console.log('catch error', addingItem)
      }
    },
    isValid(addingItem) {
      if (!addingItem.name || !addingItem.level) {
        return
      }
      return true
    }
  }
})
</script>

<style>
.container {
  /* color: white; */
  min-height: 1000px;
}
.add-item {
  display: flex;
  margin-left: auto;
  input {
  }
}
</style>
