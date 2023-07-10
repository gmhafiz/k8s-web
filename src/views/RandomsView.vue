<script lang="ts">

import {defineComponent} from "vue";

interface Random {
  id: number,
  name: string
}

export default defineComponent({
  mounted() {
    this.get()
  },
  data() {
    return {
      randoms: [] as Random[],

      address: 'http://localhost:3080'
    }
  },
  methods: {
    async get() {

      this.randoms = await fetch(`${this.address}/randoms`)
          .then((res => res.json()))
          .catch((err) => {
            console.error(err)
          });
    },
    add() {
      fetch(`${this.address}/randoms`, {
        method: "POST"
      })
          .then(() => {
            this.get()
          })
          .catch((err) => {
            console.error(err)
          })
    }
  }
})
</script>

<template>
  <div class="randoms">

    <div style="margin-top: 1rem; margin-bottom: 1rem;">
      <button
          style="padding: 0.5rem; background-color: rgba(72,154,238,0.79); color: rgb(255,255,255,0.86)"
          @click="add"
      >
        Add New UUID
      </button>
    </div>

    Last 10 Random UUID

    <div
        v-for="item in randoms"
        :key="item.id"
        style="display: flex; font-family: monospace"
    >
      <div style="min-width: 1.5rem;">
        {{ item.id }}
      </div>
      <div>
        : {{ item.name }}
      </div>

    </div>
  </div>
</template>

<style scoped>

</style>
