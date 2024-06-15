
# SQL PROJECT ON ZOMATO SALES 

Worked on  comprehensive case study on a dataset that contained information about all Zomato Sales .


## Dataset Information
 In this dataset it consists of four tables they are pizzas, pizza_types, orders, orders_details

 users : userid ,signup_date.

 sales : userid ,created_date ,product_id .

 product : product_id,product_name,price.

 goldusers_signup : userid,gold_signup_date .





##  12 Questions Explored


- 1.Total amount each coustomer spent on zomato
- 2.How many days each customer visited zomato
- 3.What was the first product purchased by each customer
- 4.What is the most purchased item on the menu and how many times it was purchased by all customers
- 5.Which item was the most popular for each customer
- 6.Which iteam was purchased by the customer after they become a member
- 7.Which iteam was purchased by the customer before they become a member
- 8.What is the total orders and how much amount spent for each member before they become member
- 9.If buying each product generates points for eg 5rs-2 zomato point and each product has different purchasing points for eg for p1 5rs 1 zomato point, for p2 10rs 5zomato point and p3 5rs-1 zomato point 2rs Izomato point calculate points collected by each customers and for which product most points have been given till now
- 10.In the first one year after a customer joins the gold program (including their join date) irrespective of what the customer has purchased they earn 5 zomato points for every 10 rs spent who earned more 1 or 3 and what was their points earnings in thier first yr?
- 11.Rank all the  transcations of the customers
- 12 Rank all the transactions for each member whenever they are a gold member for ever non gold member transaction mark as na

## Acknowledgements

 - [Awesome Readme Templates](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Awesome README](https://github.com/matiassingers/awesome-readme)
 - [How to write a Good readme](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)


## API Reference

#### Get all items

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.


## Appendix

Any additional information goes here


## Authors

- [@octokatherine](https://www.github.com/octokatherine)


## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.


## Demo

Insert gif or link to demo

