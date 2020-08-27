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
      >
        <!-- <template v-slot:top>
          <v-toolbar>
            <v-toolbar-title>My Items</v-toolbar-title>
            <v-divider
              class="mx-4"
              inset
              vertical
            ></v-divider>
            <v-spacer></v-spacer>
            <v-dialog v-model="dialog" max-width="500px">
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on"
                >New Item</v-btn>
              </template>
              <v-card>
                <v-card-title>
                  <span class="headline">new itemするときのモーダル</span>
                </v-card-title>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text>Cancel</v-btn>
                  <v-btn color="blue darken-1" text>Save</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-toolbar>
        </template> -->
        <template v-slot:item.actions="{ item }">
          <!-- <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon> -->
          <v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
        </template>
      </v-data-table>
    </div>
    <div v-if="user">
      <p>Email: {{user.email}}</p>
      <p>Username: {{user.username}}</p>
      <v-icon small class="mr-2">mdi-pencil</v-icon>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import axios from '@/plugins/axios'
export default Vue.extend({
  data() {
    return {
      dialog: false,
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
          text: 'Actions',
          value: 'actions',
          width: '15%',
          sortable: false
        }
      ]
    }
  },
  computed: {
    user() {
      return this.$store.state.currentUser
    },
    items() {
      // console.log(this.$store.state.items)
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
      // console.log('addingItem', addingItem)
      if (!this.isValid(addingItem)) return
      try {
        console.log('valid item')
        axios.post('/items', addingItem)
        this.items.push(addingItem)
        this.$store.commit("setItems", this.items)
      } catch {
        console.log('error couldnt add item')
      }
    },
    // editItem (item) {
    //   this.editedIndex = this.items.indexOf(item)
    //   this.editedItem = Object.assign({}, item)
    //   this.dialog = true
    // },
    deleteItem (deletingItem) {
      try {
        // console.log('deleting item', deletingItem.id, deletingItem)
        this.$store.commit(
          "setItems",
          this.items.filter(item => {
            return item.id !== deletingItem.id;
          })
        )
        axios.delete('/items/' + deletingItem.id)
      } catch {
        console.log('error couldnt delete')
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
}
</style>
