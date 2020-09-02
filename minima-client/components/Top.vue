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
        <v-select
          v-model="category"
          :items="categoryNameList"
          placeholder="category"
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
        <template v-slot:item.actions="{ item }">
          <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
          <v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
        </template>
      </v-data-table>
    </div>
    <div class="editItem">
      <v-dialog v-model="isShowEditModal" max-width="500px">
        <v-card-title>
          <span class="headline">アイテムを編集</span>
        </v-card-title>
        <v-card-text>
          <v-col cols="12" sm="6" md="4">
            <v-text-field v-model="editedItem.name" label="Item name"></v-text-field>
            <v-select v-model="editedItem.level" :items="levels" placeholder="level">></v-select>
            <v-select v-model="editedItem.category" :items="categoryNameList" placeholder="category"></v-select>
          </v-col>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="closeModal">Cancel</v-btn>
          <v-btn color="blue darken-1" text @click="updateItem">Save</v-btn>
        </v-card-actions>
      </v-dialog>
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
      isShowEditModal: false,
      editedIndex: -1,
      editedItem: {},
      levels: [5, 4, 3, 2, 1],
      categoryNameList: [],
      name: '',
      level: 5,
      category: '',
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
          text: 'カテゴリー',
          value: 'category_id'
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
  mounted() {
    this.categoryNameList = this.$store.state.categories.map( category => {
      return category.name
    })
    this.categoryNameList.unshift('')
    console.log('mounted categoryNameList', this.categoryNameList)
  },
  computed: {
    user() {
      return this.$store.state.currentUser
    },
    items() {
      return this.$store.state.items
    },
    categories() {
      return this.$store.state.categories
    }
  },
  methods: {
    categoryNameToCategoryId(category) {
      let category_id = null
      for (let i=0; i<this.categories.length; i++) {
        if (this.categories[i].name == category) {
          category_id = this.categories[i].id
        }
      }
      return category_id
    },
    addItem() {
      const category_id = this.categoryNameToCategoryId(this.category)
      const addingItem = {
        name: this.name,
        level: this.level,
        user_id: this.user.id,
        category_id
      }
      if (!this.isValid(addingItem)) return
      try {
        console.log('valid item')
        axios.post('/items', addingItem)
        this.items.push(addingItem)
        this.$store.commit("setItems", this.items)
        this.name = ''
      } catch {
        console.log('error couldnt add item')
      }
    },
    editItem(item) {
      this.editedIndex = this.items.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.isShowEditModal = true
    },
    updateItem() {
      const category_id = this.categoryNameToCategoryId(this.editedItem.category)
      const updatingItem = {
        name: this.editedItem.name,
        level: this.editedItem.level,
        user_id: this.user.id,
        category_id
      }
      // console.log('updatingItem', updatingItem, this.editedItem)
      if (!this.isValid(updatingItem)) return
      try {
        axios.put('/items/' + this.editedItem.id, updatingItem)
        this.$store.commit(
          "setItems",
          this.items.filter(item => {
            if (item.id === this.editedItem.id) {
              item.name = this.editedItem.name,
              item.level = this.editedItem.level,
              item.category_id = category_id
            }
            return item
          })
        )
        this.closeModal()
      } catch {
        console.log('error couldnt update')
      }
    },
    deleteItem(deletingItem) {
      try {
        // console.log('deleting item', deletingItem.id, deletingItem)
        axios.delete('/items/' + deletingItem.id)
        this.$store.commit(
          "setItems",
          this.items.filter(item => {
            return item.id !== deletingItem.id;
          })
        )
      } catch {
        console.log('error couldnt delete')
      }
    },
    closeModal() {
      this.isShowEditModal = false
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
