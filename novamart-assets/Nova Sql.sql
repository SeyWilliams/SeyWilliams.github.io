--Which 3 bundles have the highest subscription volume/count?
SELECT bundle_name, category, COUNT(s.subscription_id) AS bundle_count
FROM bundles b
INNER JOIN subscriptions s
ON b.bundle_id = s.bundle_id
INNER JOIN payments p
ON s.subscription_id = p.subscription_id
WHERE payment_status = 'Paid'
GROUP BY bundle_name, category
ORDER BY bundle_count DESC
LIMIT 3;


--What is the average spend per loyalty tier? Hint: where payment is_successful.
select loyalty_tier,avg(total_value) as average_spend
from customers c
inner join subscriptions s
on c.customer_id=s.customer_id
inner join payments p 
on s.subscription_id=p.subscription_id
where payment_status = 'Paid'
group by loyalty_tier;


--How many payments failed and what methods are used? Hint: where payment_status=failed
select payment_method, count(payment_id) as total_count
from payments
where payment_status='Failed'
group by payment_method;


--What is the total revenue by bundle category? Hint: bundle is_active, payment is_successful.
select category, sum(total_value) as revenue
from bundles b
inner join subscriptions s
on b.bundle_id=s.bundle_id
inner join payments p
on p.subscription_id=s.subscription_id
where is_active='true' and payment_status = 'Paid'
group by category
order by revenue desc;




--What issue types receive the lowest ratings?
select issue_type,avg(Rating) as Average_Rate, min(Rating)
from support_tickets
group by issue_type
order by Average_Rate
limit 1;
