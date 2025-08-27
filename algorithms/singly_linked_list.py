class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None

    def append(self, data):
        new_node = Node(data)
        if self.head is None:
            self.head = new_node
            return
        last_node = self.head
        while last_node.next:
            last_node = last_node.next
        last_node.next = new_node 

    # Imprimir la lista
    def print_list(self):
        current_node = self.head
        while current_node:
            print(current_node.data, end=" -> ")
            current_node = current_node.next
        print("None")
    

if __name__ == "__main__":
    #n = Node(14)
    #print(n.data)
    #print(n.next)

    l = LinkedList()
    l.append(1)
    l.print_list()

    print("----------")
    l.append(23)
    l.print_list()

    print("----------")
    l.append(11)
    l.print_list()

    print("----------")
    l.append(4)
    l.print_list()