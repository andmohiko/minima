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
  </div>
</template>

<script>
import Vue from 'vue'
import axios from '@/plugins/axios'
export default Vue.extend({
  data() {
    return {
      items: [],
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
        }
      ]
    }
  },
  computed: {
    // addedItem() {
    //   const formItem = this.$refs.itemName
    //   console.log(formItem)
    //   return formItem
    // }
    user() {
      return this.$store.state.currentUser;
    }
  },
  mounted() {
    this.get()
  },
  methods: {
    get() {
      axios.get('/items').then((res) => (this.items = res.data.value))
    },
    addItem() {
      const addingItem = {
        name: this.name,
        level: this.level
      }
      console.log('addingItem', addingItem)
      try {
        if (this.isValid(addingItem)) {
          console.log(addingItem)
          // axios.post('/items', addingItem)
          this.get()
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
