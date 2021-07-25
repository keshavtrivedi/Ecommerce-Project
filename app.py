# from app import app as application

from flask import *
import pymysql
import hashlib, os
from werkzeug.utils import secure_filename



conn = pymysql.connect("csmysql.cs.cf.ac.uk", "c1927485", "Kesh.Tri@091195", "c1927485_shopping")

app = Flask(__name__)

app.secret_key = 'random string'
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = set(['jpeg', 'jpg', 'png', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



def getLoginDetails():
    cur = conn.cursor()
    if 'email' not in session:
        loggedIn = False
        noOfItems = 0
    else:
        loggedIn = True
        cur.execute("SELECT userId FROM users WHERE email = '" + session['email'] + "'")
        userId = cur.fetchone()[0]
        cur.execute("SELECT count(productId) FROM cart WHERE userId = " + str(userId))
        noOfItems = cur.fetchone()[0]
    return (loggedIn, noOfItems)

@app.route("/")

def root():
    loggedIn, noOfItems = getLoginDetails()
    cur = conn.cursor()
    cur.execute('SELECT productId, name, price, description, image, stock FROM products')
    itemData = cur.fetchall()
    cur.execute('SELECT categoryId, name FROM categories')
    categoryData = cur.fetchall()
    itemData = parse(itemData)
    return render_template('welcome.html', itemData=itemData, loggedIn=loggedIn, noOfItems=noOfItems, categoryData=categoryData)

@app.route("/displayCategory")
def displayCategory():
        loggedIn,  noOfItems = getLoginDetails()
        categoryId = request.args.get("categoryId")
        cur = conn.cursor()
        cur.execute("SELECT products.productId, products.name, products.price, products.image, categories.name FROM products, categories WHERE products.categoryId = categories.categoryId AND categories.categoryId = " + categoryId)
        data = cur.fetchall()
        categoryName = data[0][4]
        data = parse(data)
        return render_template('viewCategory.html', data=data, loggedIn=loggedIn,  noOfItems=noOfItems, categoryName=categoryName)

@app.route("/loginForm")
def loginForm():
    if 'email' in session:
        return redirect(url_for('root'))
    else:
        return render_template('login.html', error='')

@app.route("/login", methods = ['POST', 'GET'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        if is_valid(email, password):
            session['email'] = email
            return redirect(url_for('root'))
        else:
            error = 'Invalid UserId / Password'
            return render_template('login.html', error=error)

@app.route("/productDescription")
def productDescription():
    loggedIn,  noOfItems = getLoginDetails()
    productId = request.args.get('productId')
    cur = conn.cursor()
    cur.execute('SELECT productId, name, price, description, image, stock FROM products WHERE productId = ' + productId)
    productData = cur.fetchone()
    return render_template("productDetail.html", data=productData, loggedIn = loggedIn,  noOfItems = noOfItems)

@app.route("/addToCart")
def addToCart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    else:
        product_id = int(request.args.get('productId'))

        cur = conn.cursor()
        cur.execute("SELECT userId FROM users WHERE email = '" + session['email'] + "'")
        user_id = cur.fetchone()[0]

        try:
            cur.execute("INSERT INTO cart(userId, productId) VALUES (%s, %s)", (user_id, product_id))
            conn.commit()
            msg = "Added successfully"
        except:
            conn.rollback()
            msg = "Error occured"
        return redirect(url_for('root'))

@app.route("/cart")
def cart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    loggedIn, noOfItems = getLoginDetails()
    email = session['email']

    cur = conn.cursor()
    cur.execute("SELECT userId FROM users WHERE email = '" + email + "'")
    userId = cur.fetchone()[0]
    cur.execute("SELECT products.productId, products.name, products.price, products.image FROM products, cart WHERE products.productId = cart.productId AND cart.userId = " + str(userId))
    products = cur.fetchall()
    totalPrice = 0
    for row in products:
        totalPrice += int(row[2])
    return render_template("cart.html", products = products, totalPrice=totalPrice, loggedIn=loggedIn,  noOfItems=noOfItems)

@app.route("/removeFromCart")
def removeFromCart():
    if 'email' not in session:
        return redirect(url_for('loginForm'))
    email = session['email']
    productId = int(request.args.get('productId'))

    cur = conn.cursor()
    cur.execute("SELECT userId FROM users WHERE email = '" + email + "'")
    userId = cur.fetchone()[0]
    try:
        cur.execute("DELETE FROM cart WHERE userId = " + str(userId) + " AND productId = " + str(productId))
        conn.commit()
        msg = "removed successfully"
    except:
        conn.rollback()
        msg = "error occured"

    return redirect(url_for('root'))

@app.route("/logout")
def logout():
    session.pop('email', None)
    return redirect(url_for('root'))

def is_valid(email, password):

    cur = conn.cursor()
    cur.execute('SELECT email, password FROM users')
    data = cur.fetchall()
    for row in data:
        if row[0] == email and row[1] == hashlib.md5(password.encode()).hexdigest():
            return True
    return False

@app.route("/register", methods = ['GET', 'POST'])
def register():
    if request.method == 'POST':

        password = request.form['password']
        email = request.form['email']

        try:
            cur = conn.cursor()
            cur.execute('INSERT INTO users (password, email) VALUES (%s, %s)', (hashlib.md5(password.encode()).hexdigest(), email))

            conn.commit()

            msg = "Registered Successfully"
        except:
            conn.rollback()
            msg = "Error occured"

        return render_template("login.html", error=msg)

@app.route("/registerationForm")
def registrationForm():
    return render_template("register.html")

@app.route("/checkout")
def checkoutForm():
    return render_template("checkout.html")

def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

def parse(data):
    ans = []
    i = 0
    while i < len(data):
        curr = []
        for j in range(7):
            if i >= len(data):
                break
            curr.append(data[i])
            i += 1
        ans.append(curr)
    return ans

if __name__ == '__main__':

    app.run(debug=True)
