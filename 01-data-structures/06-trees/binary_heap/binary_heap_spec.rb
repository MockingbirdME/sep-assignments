include RSpec

require_relative 'binary_heap'

RSpec.describe BinaryHeap, type: Class do
  let (:tree) { BinaryHeap.new(root) }
  let (:aliens) { Node.new("Aliens", 98) }
  let (:apocalypse) { Node.new("Apocalypse Now redux", 90) }
  let (:alien) { Node.new("Alien", 97) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:rings) { Node.new("The Lord of the Rings", 50) }
  let (:strawberries) { Node.new("Wild Strawberries", 95) }
  let (:rogue) { Node.new("Rogue One: A Star Wars Story", 84) }
  let (:root) { Node.new("The Terminator", 100) }
  let (:hobbit) { Node.new("The Hobbit", 67) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:awakens) { Node.new("Star Wars: The Force Awakens", 92) }

  describe "#insert(data)" do
    it "properly inserts a first new node to the left" do
      tree.insert(root, alien)
      expect(root.left.title).to eq "Alien"
    end

    it "properly inserts a second new node to the right" do
      tree.insert(root, hobbit)
      tree.insert(root, rogue)
      expect(root.right.title).to eq "Rogue One: A Star Wars Story"
    end

    it "properly inserts a third node with value less than the first" do
      tree.insert(root, aliens)
      tree.insert(root, hope)
      tree.insert(root, rings)
      expect(root.left.left.title).to eq "The Lord of the Rings"
    end

    it "properly inserts a new node as a child and swaps it with it's parent if it has a greater rating" do
      tree.insert(root, hobbit) #67
      tree.insert(root, hope) #93
      tree.insert(root, rings) #50
      tree.insert(root, apocalypse) #90
      expect(root.right.title).to eq "Star Wars: A New Hope"
      expect(root.left.title).to eq "Apocalypse Now redux"
      expect(root.left.right.title).to eq "The Hobbit"
    end
  end

  describe "#find(data)" do
    before(:each) do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.insert(root, alien)
      tree.insert(root, strawberries)
      tree.insert(root, hope)
      tree.insert(root, jedi)
    end
    it "handles nil gracefully" do
      expect(tree.find(root, nil)).to eq nil
    end

    it "properly finds a left node" do
      expect(tree.find(root, aliens.title).title).to eq "Aliens"
    end

    it "properly finds a left-left node" do
      expect(tree.find(root, alien.title).title).to eq "Alien"
    end

    it "properly finds a left-right node" do
      expect(tree.find(root, strawberries.title).title).to eq "Wild Strawberries"
    end

    it "properly finds a right node" do
      expect(tree.find(root, empire.title).title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly finds a right-left node" do
      expect(tree.find(root, hope.title).title).to eq "Star Wars: A New Hope"
    end

    it "properly finds a right-right node" do
      expect(tree.find(root, jedi.title).title).to eq "Star Wars: Return of the Jedi"
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(tree.delete(root, nil)).to eq nil
    end

    it "properly deletes a left node" do
      tree.insert(root, aliens)
      tree.delete(root, aliens.title)
      expect(tree.find(root, aliens.title)).to be_nil
    end

    it "properly deletes a left-left node" do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.insert(root, alien)
      tree.delete(root, alien.title)
      expect(tree.find(root, alien.title)).to be_nil
    end

    it "properly deletes a left-right node" do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.insert(root, alien)
      tree.insert(root, strawberries)
      tree.delete(root, strawberries.title)
      expect(tree.find(root, strawberries.title)).to be_nil
    end

    it "properly deletes a right node" do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.delete(root, empire.title)
      expect(tree.find(root, empire.title)).to be_nil
    end

    it "properly deletes a right-left node" do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.insert(root, alien)
      tree.insert(root, strawberries)
      tree.insert(root, hope)
      tree.delete(root, hope.title)
      expect(tree.find(root, hope.title)).to be_nil
    end

    it "properly deletes a right-right node" do
      tree.insert(root, aliens)
      tree.insert(root, empire)
      tree.insert(root, alien)
      tree.insert(root, strawberries)
      tree.insert(root, hope)
      tree.insert(root, jedi)
      tree.delete(root, jedi.title)
      expect(tree.find(root, jedi.title)).to be_nil
    end
  end
  describe "#printf" do
     specify {
       expected_output = "The Terminator: 100\nAliens: 98\nAlien: 97\nWild Strawberries: 95\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\nStar Wars: The Force Awakens: 92\nApocalypse Now redux: 90\nRogue One: A Star Wars Story: 84\nStar Wars: Return of the Jedi: 80\nThe Hobbit: 67\nThe Lord of the Rings: 50\n"
       tree.insert(root, aliens)   #
       tree.insert(root, alien)
       tree.insert(root, strawberries)   #
       tree.insert(root, empire)  #
       tree.insert(root, hope)
       tree.insert(root, awakens)
       tree.insert(root, apocalypse)  #
       tree.insert(root, rogue) #
       tree.insert(root, jedi) #
       tree.insert(root, hobbit) #
       tree.insert(root, rings)
       expect { tree.printf }.to output(expected_output).to_stdout
     }

  end


end
