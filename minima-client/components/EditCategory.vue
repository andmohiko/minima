<template>
  <div class="categories">
    <p class="title">カテゴリーを管理する</p>
    <div class="categories-table">
      <v-data-table
        :headers="headers"
        :items="categories"
        :items-per-page="20"
        class="elevation-1"
      >
        <template v-slot:item.actions="{ item }">
          <!-- <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon> -->
          <!-- <v-icon small class="mr-2">mdi-pencil</v-icon> -->
          <v-icon small @click="deleteCategory(item)">mdi-delete</v-icon>
        </template>
      </v-data-table>
    </div>
    <div class="add-category">
      <div>
        <v-text-field
          v-model="name"
          type="text"
          placeholder="name"
        ></v-text-field>
      </div>
      <v-btn @click="addCategory">add category</v-btn>
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
      levels: [],
      name: '',
      headers: [
        {
          text: '名前',
          value: 'name'
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
      return this.$store.state.items
    },
    categories() {
      return this.$store.state.categories
    }
  },
  methods: {
    addCategory() {
      const addingCategory = {
        name: this.name,
        user_id: this.user.id
      }
      if (!this.isValid(addingCategory)) return
      try {
        axios.post('/categories', addingCategory)
        this.categories.push(addingCategory)
        this.$store.commit("setCategories", this.categories)
        this.name = ''
      } catch {
        console.log('error couldnt add category')
      }
    },
  //   editItem(item) {
  //     this.editedIndex = this.items.indexOf(item)
  //     this.editedItem = Object.assign({}, item)
  //     this.isShowEditModal = true
  //   },
  //   updateItem() {
  //     const updatingItem = {
  //       name: this.editedItem.name,
  //       level: this.editedItem.level,
  //       user_id: this.user.id
  //     }
  //     // console.log('updatingItem', updatingItem, this.editedItem)
  //     if (!this.isValid(updatingItem)) return
  //     try {
  //       axios.put('/items/' + this.editedItem.id, updatingItem)
  //       this.$store.commit(
  //         "setItems",
  //         this.items.filter(item => {
  //           if (item.id === this.editedItem.id) {
  //             item.name = this.editedItem.name,
  //             item.level = this.editedItem.level
  //           }
  //           return item
  //         })
  //       )
  //     this.closeModal()
  //     } catch {
  //       console.log('error couldnt update')
  //     }
  //   },
    deleteCategory(deletingCategory) {
      try {
        axios.delete('/categories/' + deletingCategory.id)
        this.$store.commit(
          "setCategories",
          this.categories.filter(category => {
            return category.id !== deletingCategory.id;
          })
        )
      } catch {
        console.log('error couldnt delete')
      }
    },
  //   closeModal() {
  //     this.isShowEditModal = false
  //   },
    isValid(addingCategory) {
      if (!addingCategory.name) {
        return
      }
      return true
    }
  }
})
</script>

<style scoped lang="scss">

p {
  font-size: 24px;
}

</style>