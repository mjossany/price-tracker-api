-- Seed data for development and testing
-- WARNING: This creates test data. Do not run in production!

-- ============================================
-- CLEANUP (for development reset)
-- ============================================
-- Uncomment these lines to reset database during development
DELETE FROM price_history;
DELETE FROM product_links;
DELETE FROM products;
DELETE FROM users;

-- ============================================
-- TEST USERS
-- ============================================

-- Test user 1: Regular user
INSERT INTO users (id, name, email, password_hash, email_verified, is_active) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 
     'John Doe', 
     'john@example.com', 
     '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4j5j8.5K2', -- password: "password123"
     true, 
     true);

-- Test user 2: Another user
INSERT INTO users (id, name, email, password_hash, email_verified, is_active) VALUES
    ('550e8400-e29b-41d4-a716-446655440002', 
     'Jane Smith', 
     'jane@example.com', 
     '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4j5j8.5K2', -- password: "password123"
     true, 
     true);

-- ============================================
-- TEST PRODUCTS
-- ============================================

-- John's products
INSERT INTO products (id, user_id, name, description, target_price, currency, notification_enabled, is_active) VALUES
    ('650e8400-e29b-41d4-a716-446655440001', 
     '550e8400-e29b-41d4-a716-446655440001',
     'Sony WH-1000XM5 Headphones',
     'Premium noise-canceling wireless headphones',
     299.99,
     'USD',
     true,
     true),
    
    ('650e8400-e29b-41d4-a716-446655440002', 
     '550e8400-e29b-41d4-a716-446655440001',
     'iPhone 15 Pro 256GB',
     'Latest iPhone with titanium design',
     999.00,
     'USD',
     true,
     true);

-- Jane's products
INSERT INTO products (id, user_id, name, description, target_price, currency, notification_enabled, is_active) VALUES
    ('650e8400-e29b-41d4-a716-446655440003', 
     '550e8400-e29b-41d4-a716-446655440002',
     'MacBook Pro 14" M3',
     'Apple MacBook Pro with M3 chip',
     1999.00,
     'USD',
     true,
     true);

-- ============================================
-- TEST PRODUCT LINKS
-- ============================================

-- Sony Headphones - Multiple store links
INSERT INTO product_links (id, product_id, url, store, product_identifier, last_price, lowest_price_seen, highest_price_seen, last_checked_at, is_active) VALUES
    ('750e8400-e29b-41d4-a716-446655440001',
     '650e8400-e29b-41d4-a716-446655440001',
     'https://www.amazon.com/dp/B09XYZ123',
     'amazon',
     'B09XYZ123',
     279.99,
     249.99,
     399.99,
     NOW() - INTERVAL '2 hours',
     true),
    
    ('750e8400-e29b-41d4-a716-446655440002',
     '650e8400-e29b-41d4-a716-446655440001',
     'https://www.bestbuy.com/site/sony-wh-1000xm5/6543210.p',
     'bestbuy',
     '6543210',
     299.99,
     279.99,
     399.99,
     NOW() - INTERVAL '1 hour',
     true),
    
    ('750e8400-e29b-41d4-a716-446655440003',
     '650e8400-e29b-41d4-a716-446655440001',
     'https://www.walmart.com/ip/sony-wh-1000xm5/123456789',
     'walmart',
     '123456789',
     289.99,
     269.99,
     399.99,
     NOW() - INTERVAL '3 hours',
     true);

-- iPhone 15 Pro - Amazon and Best Buy
INSERT INTO product_links (id, product_id, url, store, product_identifier, last_price, lowest_price_seen, highest_price_seen, last_checked_at, is_active) VALUES
    ('750e8400-e29b-41d4-a716-446655440004',
     '650e8400-e29b-41d4-a716-446655440002',
     'https://www.amazon.com/dp/B0CHX1W1XY',
     'amazon',
     'B0CHX1W1XY',
     1099.00,
     999.00,
     1199.00,
     NOW() - INTERVAL '1 hour',
     true),
    
    ('750e8400-e29b-41d4-a716-446655440005',
     '650e8400-e29b-41d4-a716-446655440002',
     'https://www.bestbuy.com/site/iphone-15-pro/6543211.p',
     'bestbuy',
     '6543211',
     1099.00,
     999.00,
     1199.00,
     NOW() - INTERVAL '2 hours',
     true);

-- MacBook Pro - Only Amazon
INSERT INTO product_links (id, product_id, url, store, product_identifier, last_price, lowest_price_seen, highest_price_seen, last_checked_at, is_active) VALUES
    ('750e8400-e29b-41d4-a716-446655440006',
     '650e8400-e29b-41d4-a716-446655440003',
     'https://www.amazon.com/dp/B0CHX2W2XY',
     'amazon',
     'B0CHX2W2XY',
     1899.00,
     1799.00,
     2199.00,
     NOW() - INTERVAL '30 minutes',
     true);

-- ============================================
-- TEST PRICE HISTORY
-- ============================================

-- Sony Headphones - Amazon price history (last 7 days)
INSERT INTO price_history (product_link_id, price, original_price, discount_percentage, currency, was_available, scrape_source, response_time_ms, checked_at) VALUES
    ('750e8400-e29b-41d4-a716-446655440001', 399.99, 399.99, 0.00, 'USD', true, 'beautifulsoup', 1250, NOW() - INTERVAL '7 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 379.99, 399.99, 5.00, 'USD', true, 'beautifulsoup', 1180, NOW() - INTERVAL '6 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 349.99, 399.99, 12.50, 'USD', true, 'beautifulsoup', 1320, NOW() - INTERVAL '5 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1100, NOW() - INTERVAL '4 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 279.99, 399.99, 30.00, 'USD', true, 'beautifulsoup', 1050, NOW() - INTERVAL '3 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 269.99, 399.99, 32.50, 'USD', true, 'beautifulsoup', 980, NOW() - INTERVAL '2 days'),
    ('750e8400-e29b-41d4-a716-446655440001', 279.99, 399.99, 30.00, 'USD', true, 'beautifulsoup', 1200, NOW() - INTERVAL '1 day'),
    ('750e8400-e29b-41d4-a716-446655440001', 279.99, 399.99, 30.00, 'USD', true, 'beautifulsoup', 1150, NOW() - INTERVAL '2 hours');

-- Sony Headphones - Best Buy price history
INSERT INTO price_history (product_link_id, price, original_price, discount_percentage, currency, was_available, scrape_source, response_time_ms, checked_at) VALUES
    ('750e8400-e29b-41d4-a716-446655440002', 399.99, 399.99, 0.00, 'USD', true, 'beautifulsoup', 1400, NOW() - INTERVAL '7 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 379.99, 399.99, 5.00, 'USD', true, 'beautifulsoup', 1350, NOW() - INTERVAL '6 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 329.99, 399.99, 17.50, 'USD', true, 'beautifulsoup', 1280, NOW() - INTERVAL '5 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1200, NOW() - INTERVAL '4 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1250, NOW() - INTERVAL '3 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1180, NOW() - INTERVAL '2 days'),
    ('750e8400-e29b-41d4-a716-446655440002', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1300, NOW() - INTERVAL '1 day'),
    ('750e8400-e29b-41d4-a716-446655440002', 299.99, 399.99, 25.00, 'USD', true, 'beautifulsoup', 1220, NOW() - INTERVAL '1 hour');

-- iPhone 15 Pro - Amazon price history
INSERT INTO price_history (product_link_id, price, original_price, discount_percentage, currency, was_available, scrape_source, response_time_ms, checked_at) VALUES
    ('750e8400-e29b-41d4-a716-446655440004', 1199.00, 1199.00, 0.00, 'USD', true, 'beautifulsoup', 2100, NOW() - INTERVAL '7 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1149.00, 1199.00, 4.17, 'USD', true, 'beautifulsoup', 1950, NOW() - INTERVAL '6 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 2050, NOW() - INTERVAL '5 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 1980, NOW() - INTERVAL '4 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 2200, NOW() - INTERVAL '3 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 1900, NOW() - INTERVAL '2 days'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 2100, NOW() - INTERVAL '1 day'),
    ('750e8400-e29b-41d4-a716-446655440004', 1099.00, 1199.00, 8.34, 'USD', true, 'beautifulsoup', 2050, NOW() - INTERVAL '1 hour');

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Show summary of seed data
SELECT 'Users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Product Links', COUNT(*) FROM product_links
UNION ALL
SELECT 'Price History', COUNT(*) FROM price_history;

-- Show products with their links and latest prices
SELECT 
    p.name as product_name,
    u.name as user_name,
    pl.store,
    pl.last_price,
    pl.url
FROM products p
JOIN users u ON p.user_id = u.id
JOIN product_links pl ON p.id = pl.product_id
ORDER BY p.name, pl.store;

-- Show price trends for Sony headphones
SELECT 
    pl.store,
    ph.price,
    ph.checked_at
FROM price_history ph
JOIN product_links pl ON ph.product_link_id = pl.id
JOIN products p ON pl.product_id = p.id
WHERE p.name LIKE '%Sony%'
ORDER BY pl.store, ph.checked_at DESC;